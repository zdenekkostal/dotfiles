# Oh my ZSH stuff
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  asdf
  docker
  fzf
  gcloud
  gitfast
  mix
  ssh-agent
  tmux
)

source $ZSH/oh-my-zsh.sh

####################################################

# Enable direnv - sets shell variables per directory
eval "$(direnv hook zsh)"

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env

# Reload .profile stuff which would be loaded otherwise just after logging in
[ -f ~/.profile ] && source ~/.profile

####################################################
# Functions

function terminal-scheme {
  sed -i '' -e "s#^colors:.*#colors: \*$1#g" ~/.config/alacritty/alacritty.yml
  sed -i '' -e "s#^set background=.*#set background=$1#g" ~/dotfiles/config/nvim/init.vim
}

alias light="terminal-scheme light"
alias dark="terminal-scheme dark"

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias apply-patch="pbpaste | sed -e '$a' | git apply"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
