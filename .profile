# Homebrew installation path on Apple silicon
export PATH="/opt/homebrew/bin:$PATH"

# Add support for current project Node binaries
export PATH="node_modules/.bin:$PATH"

# Prefer Rust installed with the recommended way 
export PATH="$HOME/.cargo/bin:$PATH"

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

export DOCKER_DEFAULT_PLATFORM=linux/amd64

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
