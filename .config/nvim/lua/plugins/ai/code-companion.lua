local function url_encode(str)
  if str then
    str = string.gsub(str, "([^%w%-%.%_%~])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
  end
  return str
end

-- Standalone Bedrock Converse adapter (not extending anthropic to avoid body format conflicts)
local function bedrock_adapter()
  local adapter_utils = require("codecompanion.utils.adapters")

  return {
    name = "bedrock",
    type = "http",
    formatted_name = "AWS Bedrock",
    roles = {
      llm = "assistant",
      user = "user",
    },
    features = {
      tokens = false,
      text = true,
    },
    opts = {
      stream = true,
    },
    url = "https://bedrock-runtime."
      .. (os.getenv("AWS_REGION") or "eu-west-1")
      .. ".amazonaws.com/model/${model_id}/converse-stream",
    env = {
      api_key = "AWS_BEARER_TOKEN_BEDROCK",
      model_id = function(adapter)
        local model = adapter.schema.model.default
        return url_encode(model)
      end,
    },
    headers = {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "Bearer ${api_key}",
    },
    parameters = {},
    handlers = {
      setup = function(self)
        return true
      end,

      -- Build the complete request body for Bedrock Converse API
      set_body = function(self, data)
        local system_prompts = {}
        local converse_messages = {}

        -- Helper to check if string is non-empty after trimming
        local function is_non_empty(str)
          return str and type(str) == "string" and str:match("%S") ~= nil
        end

        -- Process messages
        for _, msg in ipairs(data.messages or {}) do
          if msg.role == "system" then
            if is_non_empty(msg.content) then
              table.insert(system_prompts, { text = msg.content })
            end
          else
            local content = {}
            if type(msg.content) == "string" then
              if is_non_empty(msg.content) then
                table.insert(content, { text = msg.content })
              end
            elseif type(msg.content) == "table" then
              for _, c in ipairs(msg.content) do
                local text_content = c.text or (c.type == "text" and c.content)
                if is_non_empty(text_content) then
                  table.insert(content, { text = text_content })
                end
              end
            end
            if #content > 0 then
              table.insert(converse_messages, {
                role = msg.role == "assistant" and "assistant" or "user",
                content = content,
              })
            end
          end
        end

        -- Build the Bedrock Converse API body
        local body = {
          messages = converse_messages,
          inferenceConfig = {
            maxTokens = self.parameters.max_tokens or 4096,
            temperature = self.parameters.temperature or 0,
          },
        }

        if self.parameters.top_p then
          body.inferenceConfig.topP = self.parameters.top_p
        end

        if #system_prompts > 0 then
          body.system = system_prompts
        end

        return body
      end,

      -- Return empty tables to prevent parent handlers from adding incompatible fields
      form_messages = function(self, messages)
        return {}
      end,

      form_parameters = function(self, params, messages)
        return {}
      end,

      chat_output = function(self, data, tools)
        if not data or data == "" then
          return
        end

        -- Clean the data if it's streamed
        if self.opts and self.opts.stream then
          data = adapter_utils.clean_streamed_data(data)
        end

        local ok, json = pcall(vim.json.decode, data, { luanil = { object = true } })
        if not ok then
          return
        end

        local output = {}

        if json.messageStart then
          output.role = json.messageStart.role or "assistant"
          output.content = ""
        elseif json.contentBlockStart then
          output.role = "assistant"
          output.content = ""
        elseif json.contentBlockDelta then
          if json.contentBlockDelta.delta and json.contentBlockDelta.delta.text then
            output.content = json.contentBlockDelta.delta.text
          end
        elseif json.messageStop then
          return { status = "success", output = { content = "" } }
        elseif json.metadata then
          return { status = "success", output = { content = "" } }
        end

        if output.content or output.role then
          return { status = "success", output = output }
        end
      end,

      on_exit = function(self, data)
        if data and data.status and data.status >= 400 then
          vim.notify(string.format("Bedrock API error %s: %s", data.status, data.body or ""), vim.log.levels.ERROR)
        end
      end,
    },
    schema = {
      model = {
        order = 1,
        mapping = "parameters",
        type = "enum",
        desc = "AWS Bedrock Claude model",
        default = os.getenv("ANTHROPIC_DEFAULT_OPUS_MODEL") or "global.anthropic.claude-opus-4-6-v1",
        choices = {
          [os.getenv("ANTHROPIC_DEFAULT_OPUS_MODEL") or "global.anthropic.claude-opus-4-6-v1"] = { formatted_name = "Opus" },
          [os.getenv("ANTHROPIC_DEFAULT_SONNET_MODEL") or "global.anthropic.claude-sonnet-4-6"] = { formatted_name = "Sonnet" },
          [os.getenv("ANTHROPIC_DEFAULT_HAIKU_MODEL") or "global.anthropic.claude-haiku-4-5-20251001-v1:0"] = { formatted_name = "Haiku" },
        },
      },
      max_tokens = {
        order = 2,
        mapping = "parameters",
        type = "number",
        optional = true,
        default = 4096,
        desc = "Maximum tokens to generate",
      },
      temperature = {
        order = 3,
        mapping = "parameters",
        type = "number",
        optional = true,
        default = 0,
        desc = "Temperature for response randomness",
      },
      top_p = {
        order = 4,
        mapping = "parameters",
        type = "number",
        optional = true,
        default = nil,
        desc = "Top P sampling parameter",
      },
    },
  }
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      opts = {
        log_level = "DEBUG",
      },
      display = {
        chat = {
          window = {
            layout = "float",
            border = "single",
            height = 0.9,
            width = 0.9,
            relative = "editor",
          },
        },
      },
      interactions = {
        chat = {
          adapter = "bedrock",
        },
        inline = {
          adapter = "bedrock",
        },
        cmd = {
          adapter = "bedrock",
        },
      },
    })

    -- Register adapter AFTER setup so it doesn't get overwritten
    local config = require("codecompanion.config")
    config.adapters.http.bedrock = bedrock_adapter
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "[a]i [a]ssistant toggle" },
    { "<leader>ac", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[a]i a[c]tions" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "[a]i [i]nline" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to chat" },
  },
}
