return {
  'ntpeters/vim-better-whitespace',
  config = function()
    vim.g.better_whitespace_enabled = 1
    vim.g.strip_whitespace_on_save = 1
    vim.g.strip_whitespace_confirm = 0
    vim.g.strip_only_modified_lines = 1
  end
}
