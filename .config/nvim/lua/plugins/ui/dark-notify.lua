return {
  'cormacrelf/dark-notify',
  config = function()
    -- Read theme config from ~/.config/theme.conf
    local function get_theme_conf(section, key)
      local conf_path = vim.fn.expand('~/.config/theme.conf')
      local current_section = ''
      for line in io.lines(conf_path) do
        local s = line:match('^%[(.+)%]$')
        if s then
          current_section = s
        elseif current_section == section then
          local k, v = line:match('^(%S+)%s*=%s*(.+)$')
          if k == key then
            return v
          end
        end
      end
      return nil
    end

    require('dark_notify').run({
      schemes = {
        dark = get_theme_conf('dark', 'nvim_colorscheme') or 'rose-pine-main',
        light = get_theme_conf('light', 'nvim_colorscheme') or 'gruvbox',
      },
      onchange = function(mode)
        local bg = get_theme_conf(mode, 'nvim_background') or mode
        local cs = get_theme_conf(mode, 'nvim_colorscheme') or (mode == 'dark' and 'rose-pine-main' or 'gruvbox')
        local lualine_theme = get_theme_conf(mode, 'lualine') or 'auto'

        vim.api.nvim_set_option_value('background', bg, {})
        vim.cmd('colorscheme ' .. cs)

        -- Update lualine theme
        local ok, lualine = pcall(require, 'lualine')
        if ok then
          lualine.setup({ options = { theme = lualine_theme } })
        end
      end,
    })
  end,
}
