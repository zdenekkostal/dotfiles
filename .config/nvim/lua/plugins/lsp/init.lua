return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {'hrsh7th/cmp-nvim-lsp'},
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
          vim.diagnostic.goto_next({ severity = "Error" })
        end , opts)
        vim.keymap.set('n', '<leader>E', function() 
          vim.diagnostic.goto_prev({ severity = "Error" })
        end , opts)
      end,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "single"
      }
    )

    local lspconfig = require('lspconfig')
    local servers = { 'tsserver', 'jsonls', 'terraformls' }

    require('lspconfig').gopls.setup({
      settings = {
        gopls = {
          gofumpt = true
        }
      }
    })

    require('lspconfig').rust_analyzer.setup({
      settings = {
        rust_analyzer = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      }
    })

    for _, server in ipairs(servers) do
      lspconfig[server].setup {
        capabilities = capabilities,
      }
    end
  end
}
