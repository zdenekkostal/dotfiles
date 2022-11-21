# Private profile vars
[ -f ~/.private/profile ] && source ~/.private/profile

# Homebrew installation path on Apple silicon
export PATH="/opt/homebrew/bin:$PATH"

# Add asdf to the path so it can find all languages
if command -v asdf >/dev/null 2>&1; then
  export PATH="$HOME/.asdf/shims:$PATH"
fi

# and for global yarn modules
if command -v yarn >/dev/null 2>&1; then
  export PATH="$(yarn global bin):$PATH"
fi

if command -v go >/dev/null 2>&1; then
  export PATH="$(go env GOPATH)/bin:$PATH"
fi

# Add support for current project Node binaries
export PATH="node_modules/.bin:$PATH"

# ... every other language will be prepended via asdf

####################################################
### And go to other stuff!

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'

# Set up better git commit message formatting in vim
export RI="--format ansi --width 70"

# Enable shell history in iex
export ERL_AFLAGS="-kernel shell_history enabled"

# Silence direnv to avoid text output when opening a new shell
export DIRENV_LOG_FORMAT=

# Let's use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --follow 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZK_NOTEBOOK_DIR="$HOME/notes/"
