
#----------------------------------------
# Prompt Functions
#----------------------------------------
#
#  display_prompt
#       Run before each prompt is displayed. If the current prompt theme has
#       defined a *_generator function, then it will be run here.
#
#  set_prompt
#       Used to set the prompt theme. Toggles the $ZSH_PROMPT variable, and
#       runs a *_setup function if it's defined.
#
function display_prompt()
{
    # Locally store the return code for later
    local return_code=$?

    # No prompt is setup. Do nothing.
    if [ -z "$ZSH_PROMPT" ]; then
        return $return_code
    fi

    # if the current prompt has a generator function defined, then run it.
    if type "${ZSH_PROMPT}_generator" | grep -q 'shell function'; then
        eval "${ZSH_PROMPT}_generator"
    fi

    # Make sure that we preserve the value of $?
    return $return_code
}

function set_prompt()
{
    if [ -n "$1" ]; then
        echo "usage: set_prompt PROMPT"
        return 1
    fi

    ZSH_PROMPT="$1"

    # If a function named "${ZSH_PROMPT}_setup" exists, run it
    if type "${ZSH_PROMPT}_setup" | grep -q 'shell function'; then
        eval "${ZSH_PROMPT}_setup"
    fi
}

#----------------------------------------
# PROMPT: Basic Prompts
#----------------------------------------
function bare_prompt_setup()    { export PS1="${PROMPT_RETURN_CODE_TEXT}> "    ; unset ZSH_PROMPT; }
function plain_prompt_setup()   { export PS1="${PROMPT_RETURN_CODE_TEXT}%m> "  ; unset ZSH_PROMPT; }
function basic_prompt_setup()   { export PS1="${PROMPT_RETURN_CODE_TEXT}%n@%m> ";unset ZSH_PROMPT; }

#----------------------------------------
# PROMPT: My Prompt 1
#----------------------------------------
#  A Debian-inspired prompt
#
function my_prompt_1_setup()
{
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{%F{green}%n@%m%f:%F{blue}%~%f\$(git_prompt_info)
%}$retcode%% "
}

#----------------------------------------
# PROMPT: My Prompt 2
#----------------------------------------
#  A Debian-inspired prompt
#
function my_prompt_2_setup()
{
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{[ %F{green}%n@%m%f | %F{blue}$~%f\$(git_prompt_info) ]
%}$retcode%% "
}

#----------------------------------------
# PROMPT: Fancy Prompt 1
#----------------------------------------

function fancy_prompt_1_setup()
{
    local decor_start='%F{green}(%f'
    local decor_end='%F{green})%f'
    local divider='%F{green})-(%f'
    local host_part='%F{blue}%n@%M%f'
    local path_part='%F{yellow}%d%f'
    local time_part='%F{blue}%D %*%f'
    local tty_part='%F{magenta}%y%f'
    local git_branch_display='$__GIT_BRANCH_FORMAT'
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{${decor_start}${host_part}${divider}${path_part}${divider}${tty_part}${divider}${time_part}${decor_end}${git_branch_display}
%}$retcode%F{green}%!%%%f "
}

function fancy_prompt_1_generator()
{
    local GIT_BRANCH_NAME=$(git_branch)
    local IS_GIT_REPO=$(is_git_repo)
    __GIT_BRANCH_FORMAT=""
    test -z "$GIT_BRANCH_NAME" -a "$IS_GIT_REPO" -eq "0" && local GIT_BRANCH_NAME="<null>"
    test -n "$GIT_BRANCH_NAME" && __GIT_BRANCH_FORMAT="%F{green}-(%fgit:%F{blue}${GIT_BRANCH_NAME}%F{green})%f"
    export __GIT_BRANCH_FORMAT
}

#----------------------------------------
# Git Prompt Functions
#----------------------------------------
#  http://nullcreations.net/entries/general/zsh-prompt-to-show-git-branch
#

function git_prompt_info()
{
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " (git:${ref#refs/heads/})"
}

function is_git_repo()
{
    git status >/dev/null 2>/dev/null
    echo $?
}

function git_branch()
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

#----------------------------------------
# Prompt Setup
#----------------------------------------

autoload zsh/terminfo

if [[ -z "${precmd_functions[(R)display_prompt]}" ]]; then
    precmd_functions+='display_prompt'
fi

ZSH_PROMPT_RETCODE_TEXT="%(0?..%F{red}%?%f )"

if [ -n "$ZSH_PROMPT" ]; then
    set_prompt 'basic_prompt'
else
    set_prompt $ZSH_PROMPT
fi

# vim: set syn=zsh fdm=marker et sts=4 sw=4 ts=4 tw=100:
