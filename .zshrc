# Enable direnv - sets shell variables per directory
# also, silence it to avoid text output when opening a new shell
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env

# Enable starship - excellent shell prompt
eval "$(starship init zsh)"

# Source ZSH plugins via antibody
[ -f ~/.zsh_plugins.sh ] && source ~/.zsh_plugins.sh

####################################################
# Functions

function terminal-scheme {
  sed -i '' -e "s#^colors:.*#colors: \*$1#g" ~/.config/alacritty/alacritty.yml
  sed -i '' -e "s#^set background=.*#set background=$1#g" ~/.config/nvim/init.vim

  # Bat
  sed -i '' -e "s#^--theme=.*#--theme=\"gruvbox-$1\"#g" ~/.config/bat/config

  # Tmux
  sed -i '' -e "s#syntax-theme = .*#syntax-theme = \"gruvbox-$1\"#g" ~/.gitconfig
  tmux set-option -g @tmux-gruvbox $1
  tmux source-file ~/.tmux.conf
}

alias light="terminal-scheme light"
alias dark="terminal-scheme dark"

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias apply-patch="pbpaste | sed -e '$a' | git apply"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
