return {
  'cormacrelf/dark-notify',
  config = function()
    require('dark_notify').run({
      onchange = function(mode)
        -- Alacritty
        vim.fn.system([[sed -i '' -e "s#^colors:.*#colors: *]] .. mode .. [[#g" ~/.config/alacritty/alacritty.yml]])

        -- Bat
        vim.fn.system([[sed -i '' -e "s#^--theme=.*#--theme=\"gruvbox-]] .. mode .. [[\"#g" ~/.config/bat/config]])

        -- Tmux
        vim.fn.system([[tmux set-option -g @tmux-gruvbox ]] .. mode)
        vim.fn.system([[tmux source-file ~/.tmux.conf]])
      end
    })
  end
}
