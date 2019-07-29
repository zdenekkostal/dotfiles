# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(gitfast mix tmux ssh-agent docker httpie)

export PATH="/Users/z/.node/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/z/bin"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Python/2.7/bin:$PATH"
export PATH="/usr/local/opt/elasticsearch@5.6/bin:$PATH"
export PATH="$PATH:node_modules/.bin"

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export EDITOR='nvim'
export LANG=en_US.UTF-8
export RI="--format ansi --width 70"

# https://github.com/tmux/tmux/issues/475
export EVENT_NOKQUEUE=1

# Enable shell history in iex
export ERL_AFLAGS="-kernel shell_history enabled"

# Private stuff
[ -f ~/.private/env ] && source ~/.private/env
[ -f ~/.profile ] && source ~/.profile

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(direnv hook zsh)"

function fr {
  if [[ -n "$2" ]]; then
    rg --colors match:none --colors match:bg:yellow --colors match:fg:black --colors path:fg:green --colors path:style:bold -l $1 | xargs sed -i '' -e "s#$1#$2#g"
  else
    # rg --column --line-number --no-heading --fixed-strings --ignore-case $1 | fzf-tmux -d 15
    rg --colors match:none --colors match:bg:yellow --colors match:fg:black --colors path:fg:green --colors path:style:bold $1
  fi
}

function kill-cucumber {
  kill -9 $(ps aux | grep cucumber | awk '{print $2}')
}

function kill-everything-after-cucumber {
  kill-cucumber
  kill -9 $(ps aux | grep "test-type=webdriver" | awk '{print $2}')
}

function terminal-scheme {
  sed -i '' -e "s#^colors:.*#colors: \*$1#g" ~/.config/alacritty/alacritty.yml
  sed -i '' -e "s#^set background=.*#set background=$1#g" ~/dotfiles/config/nvim/init.vim
}

alias light="terminal-scheme light"
alias dark="terminal-scheme dark"

