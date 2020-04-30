# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/z/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/z/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/z/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/z/.fzf/shell/key-bindings.zsh"