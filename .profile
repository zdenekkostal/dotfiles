# Add support for current project Node binaries
export PATH="$PATH:node_modules/.bin"

# and for global yarn modules
if command -v yarn >/dev/null 2>&1; then
  export PATH="$(yarn global bin):$PATH"
fi

# ... every other language will be prepended via asdf

####################################################
### And go to other stuff!

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'

# https://github.com/tmux/tmux/issues/475
export EVENT_NOKQUEUE=1

# Set up better git commit message formatting in vim
export RI="--format ansi --width 70"

# Enable shell history in iex
export ERL_AFLAGS="-kernel shell_history enabled"

# Let's use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --follow 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
