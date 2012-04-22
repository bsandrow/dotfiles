#-------------------------------------------------------------------------------
# Git Shell Functions
#-------------------------------------------------------------------------------

function git_prompt_info()
{
    echo " (git:$(git_current_branch))"
}

function git_current_branch
{
    ref=$(git symbolic-ref HEAD 2> /dev/null)

    if [ $? -ne 0 ]; then
        echo "<error>"
        return 1
    else
        echo "${ref#refs/heads/}"
    fi
}

function is_git_repo()
{
    dir="${1:-$PWD}"
    (cd "$dir" && git status >/dev/null 2>/dev/null)
    return $?
}

# Sources
# =======
#
# [1] http://nullcreations.net/entries/general/zsh-prompt-to-show-git-branch
