## bash completion

# Source the main bash completion setup if it isn't already sourced
if [[ -z "$BASH_COMPLETION" ]]; then
    source /etc/bash_completion
fi

# Include custom completion files
source "$DOTFILES_BASH_DIR/git-completion.bash"
source "$DOTFILES_BASH_DIR/ssh-config-completion.bash"

# vim:ft=sh
