export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

# Thanks to https://gist.github.com/mattmc3/c490d01751d6eb80aa541711ab1d54b1

# remove superfluous blanks from each command line being added to the history list
setopt hist_reduce_blanks

# don't write a duplicate event to the history file
setopt hist_save_no_dups

# write to the history file immediately, not when the shell exits
setopt inc_append_history

# share history between all sessions
setopt share_history

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
  docker
  kubectl
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
