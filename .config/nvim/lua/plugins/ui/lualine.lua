return {
  'nvim-lualine/lualine.nvim',
  requires = {
    {'kyazdani42/nvim-web-devicons', opt = true}
  },
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
      },
      tabline = {
        lualine_a = {
          {'tabs', mode = 1}
        },
      }
    }
  end
}
