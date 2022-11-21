export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env

# Enable starship - excellent shell prompt
eval "$(starship init zsh)"

plugins=(
  yarn
  asdf
  gitfast
  fzf
  tig
  direnv
)

# Load plugins
eval "$(sheldon source)"

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

alias rg="rg --hidden --glob '!.git'"

alias aws="op run --env-file=$HOME/.config/op/aws-env -- aws"

function wallpaper {
  if [[ -f "$1" ]] && command -v osascript >/dev/null 2>&1; then
   osascript -e 'tell application "System Events" to tell every desktop to set picture to "'$1'"'
  fi
}
