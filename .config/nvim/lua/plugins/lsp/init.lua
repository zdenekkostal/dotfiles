return {
  'neovim/nvim-lspconfig',
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true }
      print("'" .. client.name .. "' language server started" )

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

      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.goto_next({ severity = "Error" })<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.goto_prev({ severity = "Error" })<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rr', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>', opts)
    end

    -- https://github.com/neovim/neovim/pull/12655
    -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    --   vim.lsp.diagnostic.on_publish_diagnostics, {
    --     underline = true,
    --     virtual_text = true,
    --     signs = true,
    --     update_in_insert = true,
    --   }
    -- )

    lspconfig.tsserver.setup{ on_attach = on_attach, capabilities = capabilities }
    lspconfig.html.setup{ on_attach = on_attach }
    lspconfig.gopls.setup{ on_attach = on_attach }
    lspconfig.rust_analyzer.setup{ on_attach = on_attach }

    vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
      if err ~= nil or result == nil then
        return
      end

      if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
          vim.api.nvim_command("noautocmd :update")
        end
      end
    end

    local efm_on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command [[augroup Format]]
        vim.api.nvim_command [[autocmd! * <buffer>]]
        vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
        vim.api.nvim_command [[augroup END]]
      end
    end

    lspconfig.efm.setup{ on_attach = efm_on_attach }
  end
}
