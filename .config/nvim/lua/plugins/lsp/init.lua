return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- {'hrsh7th/cmp-nvim-lsp'},
    {'saghen/blink.cmp'},
  },

  opts = {
    servers = {
      ts_ls = {},
      jsonls = {},
      terraformls = {},
      ruff = {},
      pyright = {},
      gopls = {
        gofumpt = true
      },
      rust_analyzer = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      }
    }
  },

  config = function(_, opts)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local o = { buffer = ev.buf }

        -- Neovim 0.11+ provides these built-in:
        -- gd (definition), gD (declaration), K (hover), grn (rename),
        -- gra (code action), grr (references), gri (implementation), grt (type definition)

        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, o)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, o)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, o)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, o)

        vim.keymap.set('n', '<leader>e', function()
          vim.diagnostic.jump({
            count = 1,
            severity = {
              vim.diagnostic.severity.ERROR,
              vim.diagnostic.severity.WARN,
              vim.diagnostic.severity.INFO,
            },
          })
        end, o)
        vim.keymap.set('n', '<leader>E', function()
          vim.diagnostic.jump({
            count = -1,
            severity = {
              vim.diagnostic.severity.ERROR,
              vim.diagnostic.severity.WARN,
              vim.diagnostic.severity.INFO,
            },
          })
        end, o)
      end,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "single"
      }
    )

    for server, config in pairs(opts.servers) do
      -- print(server, config)
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end
}
