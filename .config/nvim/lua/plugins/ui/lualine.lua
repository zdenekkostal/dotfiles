return {
  'hoob3rt/lualine.nvim',
  config = function()
    require('lualine').setup{
      options = {
        theme = 'rose-pine'
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1
          }
        },
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_c = {
          {
            'filename',
            path = 1
          }
        }
      }
    }
  end
}
