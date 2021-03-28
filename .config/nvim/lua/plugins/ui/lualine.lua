return {
  'hoob3rt/lualine.nvim',
  config = function()
    require('lualine').setup{
      options = {
        theme = 'gruvbox'
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            full_name = true,
            shorten = false
          }
        },
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      }
    }
  end
}
