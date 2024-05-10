return {
  "nvim-neotest/neotest",
  requires = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    
    "nvim-neotest/neotest-go",
    'nvim-neotest/neotest-jest',
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
      adapters = {
        require("neotest-go"),
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

    vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua require('neotest').run.run()<cr>", { desc = 'Run tests' })
    vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", { desc = 'Debug tests' })
    vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch' })<cr>", { desc = 'Run tests in watch mode' })
    vim.api.nvim_set_keymap("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = 'Toggle test summary' })
  end
}
