# Setup fzf
# ---------
if [[ ! "$PATH" == */home/eloi/dotfiles/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/eloi/dotfiles/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/eloi/dotfiles/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/eloi/dotfiles/fzf/shell/key-bindings.bash"
