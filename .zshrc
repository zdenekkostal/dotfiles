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
  # aws
  yarn
  golang
  gh
  gitfast
  fzf
  tig
  docker
  docker-compose
  kubectl
  make
  mise
)

# Ctrl+Space
bindkey '^I' autosuggest-accept

# Load plugins
eval "$(sheldon source)"

eval "$(mise activate zsh)"

####################################################
# Functions

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias apply-patch="pbpaste | sed -e '$a' | git apply"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias rg="rg --hidden --glob '!.git'"

function wallpaper {
  if [[ -f "$1" ]] && command -v osascript >/dev/null 2>&1; then
   osascript -e 'tell application "System Events" to tell every desktop to set picture to "'$1'"'
  fi
}

function cleandocker {
  docker stop $(docker ps -a -q)
  docker rm $(docker ps -a -q)
  docker system prune -f
  docker volume prune -f
}
