return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    {"neovim/nvim-lspconfig"},
    {'kevinhwang91/promise-async'},
    {'luukvbaal/statuscol.nvim'}
  },
  config = function()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', 'zK', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek fold'})

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        -- return {'lsp, 'indent'}
        return {'indent'}
      end
    })
  end
}
