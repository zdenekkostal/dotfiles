return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    
    { "fredrikaverpil/neotest-golang", version = "*" },
    'nvim-neotest/neotest-jest',
    "leoluz/nvim-dap-go",
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")

    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    require('neotest').setup({
      status = {
        signs = true,
        virtual_text = true,
      },
      quickfix = {
        enabled = true,
        open = true
      },
      discovery = {
        -- Drastically improve performance in ginormous projects by
        -- only AST-parsing the currently opened buffer.
        enabled = false,
        -- Number of workers to parse files concurrently.
        -- A value of 0 automatically assigns number based on CPU.
        -- Set to 1 if experiencing lag.
        concurrent = 1,
      },
      running = {
        -- Run tests concurrently when an adapter provides multiple commands to run.
        concurrent = true,
      },
      summary = {
        -- Enable/disable animation of icons.
        animated = false,
      },
      adapters = {
        require("neotest-golang", {
          runner = "gotestsum",
          go_test_args = { "-v", "-count=1" }
        }),
        require('neotest-jest')({
          jestCommand = "yarn test",
          -- jestConfigFile = "custom.jest.config.ts",
          -- env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      }
    })
  end,
  keys = {
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "[t]est [a]ttach" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile" },
      { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files" },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite" },
      { "<leader>tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel" },
      { "<leader>tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate" },
      { "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "Debug current file" },
    },
}
