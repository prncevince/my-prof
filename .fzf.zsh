BREWPREFIX=$(brew --prefix)

# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$BREWPREFIX/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$BREWPREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$BREWPREFIX/opt/fzf/shell/key-bindings.zsh"
