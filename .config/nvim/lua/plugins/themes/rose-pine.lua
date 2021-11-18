return {
  'rose-pine/neovim',
  as = 'rose-pine',
  config = function()
    -- Options (see available options below)
    vim.g.rose_pine_variant = 'base'

    vim.cmd([[
      function! MyHighlights() abort
        hi! Normal ctermbg=NONE guibg=NONE
        hi! LineNr ctermfg=NONE guibg=NONE
        hi! SignColumn ctermfg=NONE guibg=NONE

        hi! VertSplit gui=NONE guifg=#191724 guibg=NONE
        hi! EndOfBuffer ctermbg=NONE ctermfg=NONE gui=NONE guibg=NONE guifg=#191724
      endfunction

      augroup MyColors
        autocmd!
        autocmd ColorScheme * call MyHighlights()
      augroup END
    ]])

    -- Load colorscheme after options
    vim.cmd('colorscheme rose-pine')
  end
}
