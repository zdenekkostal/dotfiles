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
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        vim.keymap.set('n', '<leader>e', function() 
          vim.diagnostic.jump({
            count = 1,
            severity = {
              vim.diagnostic.severity.ERROR,
              vim.diagnostic.severity.WARN,
              vim.diagnostic.severity.INFO,
            }
          })
        end , opts)
        vim.keymap.set('n', '<leader>E', function() 
          vim.diagnostic.jump({
            count = -1,
            severity = {
              vim.diagnostic.severity.ERROR,
              vim.diagnostic.severity.WARN,
              vim.diagnostic.severity.INFO,
            }
          })
        end , opts)
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
