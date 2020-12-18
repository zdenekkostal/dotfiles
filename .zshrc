# Enable direnv - sets shell variables per directory
eval "$(direnv hook zsh)"

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env

# Reload .profile stuff which would be loaded otherwise just after logging in
[ -f ~/.profile ] && source ~/.profile

# Enable starship - excellent shell prompt
eval "$(starship init zsh)"

if command -v antibody >/dev/null 2>&1; then
  source <(antibody init)

  antibody bundle "
    ohmyzsh/ohmyzsh folder:plugins/asdf
    ohmyzsh/ohmyzsh folder:plugins/docker
    ohmyzsh/ohmyzsh folder:plugins/gitfast
    ohmyzsh/ohmyzsh folder:plugins/ssh-agent
    bigH/git-fuzzy path:bin kind:path
  "
fi

####################################################
# Functions

function terminal-scheme {
  sed -i '' -e "s#^colors:.*#colors: \*$1#g" ~/.config/alacritty/alacritty.yml
  sed -i '' -e "s#^set background=.*#set background=$1#g" ~/.config/nvim/init.vim
}

alias light="terminal-scheme light"
alias dark="terminal-scheme dark"

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias apply-patch="pbpaste | sed -e '$a' | git apply"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
