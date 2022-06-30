return {
  'neovim/nvim-lspconfig',
  requires = {
    {'ray-x/lsp_signature.nvim'},
    {'hrsh7th/cmp-nvim-lsp'},
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local lspconfig = require('lspconfig')

    local on_attach = function(client, bufnr)
      require('lsp_signature').on_attach()

      local opts = { noremap=true, silent=true }

      -- Avoid TSServer clashing with Prettier
      client.resolved_capabilities.document_formatting = false

      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.goto_next({ severity = "Error" })<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>E', '<cmd>lua vim.diagnostic.goto_prev({ severity = "Error" })<CR>', opts)
    end

    local servers = { 'tsserver', 'rust_analyzer', 'gopls' }
    for _, server in ipairs(servers) do
      lspconfig[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end
}
