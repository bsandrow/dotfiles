# Prompt
# ~~~~~~

setopt PROMPT_SUBST

export PS0="%F{202}%n%f in %F{107}%~%f on %F{1}%M%f"
export PROMPT_EXIT="%(0?.%B%F{40}:)%f%b.%B%F{red}:(%f%b)"

function prompt() {
    local STATE

    if is_git_repo; then
        local GIT_BRANCH_NAME=$(git_current_branch)
        STATE="%F{magenta}git:${GIT_BRANCH_NAME:-<null>}%f"
    fi

    if [ -n "$VIRTUAL_ENV" ]; then
        local VENV_NAME=${VIRTUAL_ENV#$WORKON_HOME/}
        [ -n "$STATE" ] && STATE="$STATE "
        STATE="$STATE%F{magenta}venv:${VENV_NAME}%f"
    fi

    if [ -n "$STATE" ]; then
        export PROMPT="$PS0 %B[%b $STATE %B]%b\n$PROMPT_EXIT "
    else
        export PROMPT="$PS0\n$PROMPT_EXIT "
    fi
}

if [[ -z "${precmd_functions[(R)prompt]}" ]]; then
    precmd_functions+='prompt'
fi

git_prompt_info() { echo " (git:$(git_current_branch))"; }

# vim:ft=zsh
