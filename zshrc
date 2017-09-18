# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git tmux ssh-agent)

export PATH="/Users/z/.node/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/z/bin:/Users/z/go/bin:/Users/z/.fzf/bin"

export EDITOR='nvim'
export LANG=en_US.UTF-8
export RI="--format ansi --width 70"

# https://github.com/tmux/tmux/issues/475
export EVENT_NOKQUEUE=1

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
