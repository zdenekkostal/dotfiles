return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    memory = {
      opts = {
        chat = {
          ---Function to determine if memory should be added to a chat buffer
          ---This requires `enabled` to be true
          ---@param chat CodeCompanion.Chat
          ---@return boolean
          condition = function(chat)
            return chat.adapter.type ~= "acp"
          end,
        },
      },
    },
    display = {
      chat = {
        icons = {
          chat_context = "📎️", -- You can also apply an icon to the fold
        },
        fold_context = true,
        window = {
          layout = "float", -- float|vertical|horizontal|buffer
          position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
          border = "single",
          height = 0.9,
          width = 0.9,
          relative = "editor",
          full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
          sticky = false, -- when set to true and `layout` is not `"buffer"`, the chat buffer will remain opened when switching tabs
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = "0",
            linebreak = true,
            list = false,
            numberwidth = 1,
            signcolumn = "no",
            spell = false,
            wrap = true,
          },
        },
      },
    },
    strategies = {
      chat = {
        adapter = "claude_code_acp",
        tools = {
          opts = {
            auto_submit_errors = true, -- Send any errors to the LLM automatically?
            auto_submit_success = true, -- Send any successful output to the LLM automatically?
          },
        },
      },
      inline = { adapter = "claude_code_acp" },
      cmd = { adapter = "claude_code_acp" },
    },
    adapters = {
      -- http = {
      --   claude_code_bedrock = function()
      --     return require("codecompanion.adapters").extend("anthropic", {
      --       name = "bedrock",
      --       url = "https://bedrock-runtime.us-east-1.amazonaws.com/model/${model}/converse",
      --       env = {
      --         AWS_BEARER_TOKEN_BEDROCK = "AWS_BEARER_TOKEN_BEDROCK",
      --       },
      --       headers = {
      --         ["Content-Type"] = "application/json",
      --         ["Authorization"] = "Bearer ${AWS_BEARER_TOKEN_BEDROCK}",
      --       },
      --       schema = {
      --         model = {
      --           default = "anthropic.claude-sonnet-4-5-20250929-v1:0",
      --         },
      --       },
      --     })
      --   end,
      -- },
      acp = {
        claude_code_acp = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              AWS_BEARER_TOKEN_BEDROCK = "AWS_BEARER_TOKEN_BEDROCK",
            },
          })
        end,
      },
    },
  },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "[c]ode [c]ompanion toggle" },
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[c]ode companion [a]ctions" },
    { "<leader>ci", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "[c]ode companion [i]nline" },
    { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to chat" },
  },
}
