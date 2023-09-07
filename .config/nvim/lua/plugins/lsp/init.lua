return {
  'neovim/nvim-lspconfig',
  requires = {
    {'hrsh7th/cmp-nvim-lsp'},
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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

    local lspconfig = require('lspconfig')
    local servers = { 'tsserver', 'rust_analyzer', 'gopls', 'jsonls', 'terraformls', 'ruby_ls' }

    -- local servers = {
    --   settings = {
    --     rust_analyzer = {
    --       ["rust-analyzer"] = {
    --         checkOnSave = {
    --           command = "clippy",
    --         },
    --       },
    --     },
    --   },
    -- }

    for _, server in ipairs(servers) do
      lspconfig[server].setup {
        -- on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end
}
