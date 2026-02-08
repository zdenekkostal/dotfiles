# Homebrew installation path on Apple silicon
export PATH="/opt/homebrew/bin:$PATH"

# Add mise to path so some tools can find the executables (like VSCode go plugin)
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Add support for current project Node binaries
export PATH="node_modules/.bin:$PATH"

# Some tools like Zed are installed here
export PATH="$PATH:$HOME/.local/bin"

# Prefer Rust installed with the recommended way 

####################################################
### And go to other stuff!

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'

export K9S_CONFIG_DIR=$HOME/.config/k9s

# Set up better git commit message formatting in vim
export RI="--format ansi --width 70"

# Enable shell history in iex
export ERL_AFLAGS="-kernel shell_history enabled"

# Silence direnv to avoid text output when opening a new shell
export DIRENV_LOG_FORMAT=

# Load .env files automatically everywhere
export MISE_ENV_FILE=.env

# Let's use ripgrep
export FZF_DEFAULT_COMMAND='rg --files --follow 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export DFT_DISPLAY=side-by-side-show-both

export ZK_NOTEBOOK_DIR="$HOME/notes/"

export DOCKER_DEFAULT_PLATFORM=linux/amd64

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
. "$HOME/.cargo/env"
