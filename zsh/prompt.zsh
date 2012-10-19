# Prompt
# ~~~~~~

setopt PROMPT_SUBST

function wrap_color() { echo "\$FG[$1]$2\$FG[reset]"; }
function wrap_meta () { echo "\$FG[005]$*\$FG[reset]"; }
function bold      () { echo "\$FX[bold]$*\$FX[no-bold]"; }

export PS0="$(wrap_color '202' '%n') in $(wrap_color '107' '%~') on $(wrap_color '001' '%M')"
export PROMPT_EXIT="%(0?.$(wrap_color '040' '\$').$(wrap_color '001' '\$'))"

function prompt() {
    metainfo=()

    if is_git_repo; then
        GIT_BRANCH_NAME=$(git_current_branch)
        metainfo+=("$(wrap_meta "git:${GIT_BRANCH_NAME:-<null>}")")
    fi

    if [ -n "$VIRTUAL_ENV" ]; then
        virtualenv_name=${VIRTUAL_ENV#$WORKON_HOME/}
        metainfo+=("$(wrap_meta "venv:${virtualenv_name}")")
    fi

    [ $#metainfo -gt 0 ] && meta="%B[%b ${(pj: :)metainfo} %B]%b"

    parts=($PS0 $meta $PROMPT_EXIT '')
    export PROMPT="${(pj: :)parts}"
    unset STATE VENV_NAME GIT_BRANCH_NAME meta
}

if [[ -z "${precmd_functions[(R)prompt]}" ]]; then
    precmd_functions+='prompt'
fi

git_prompt_info() { echo " (git:$(git_current_branch))"; }

# vim:ft=zsh
