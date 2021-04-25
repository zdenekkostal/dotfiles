return {
  'gruvbox-community/gruvbox',
  config = function()
    vim.g.gruvbox_contrast_dark = 'medium'
    vim.g.gruvbox_contrast_light = 'medium'
    vim.g.gruvbox_invert_selection = 0

    -- Make background transparent for many things
    vim.cmd[[hi! Normal ctermbg=NONE guibg=NONE]]
    vim.cmd[[hi! LineNr ctermfg=NONE guibg=NONE]]
    vim.cmd[[hi! SignColumn ctermfg=NONE guibg=NONE]]

    -- Try to hide vertical spit and end of buffer symbol
    vim.cmd[[hi! VertSplit gui=NONE guifg=#282828 guibg=NONE]]
    vim.cmd[[hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]]
  end
}
