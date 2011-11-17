# vim:syn=zsh:fdm=marker:

setopt PROMPT_SUBST
autoload zsh/terminfo

# Insert display_prompt into the precmd functions if it isn't there already
if [[ -z "${precmd_functions[(R)display_prompt]}" ]]; then
    precmd_functions+='display_prompt'
fi
ZSH_PROMPT_RETCODE_TEXT="%(0?..%F{red}%?%f )"

##########
## Display the prompt
##
function display_prompt()
{
    local return_code=$?
    if [ -n "$ZSH_PROMPT" ] && type "${ZSH_PROMPT}_generator" | grep -q 'shell function';
    then
        eval "${ZSH_PROMPT}_generator"
    fi
    return $return_code
}

##########
## Prompt chooser function
##
function set_prompt()
{
    test -n "$1" || { echo "usage: set_prompt PROMPT"; exit 1; }
    ZSH_PROMPT="$1"

    # If a function named "${ZSH_PROMPT}_setup" exists, run it
    if type "${ZSH_PROMPT}_setup" | grep -q 'shell function'; then
        eval "${ZSH_PROMPT}_setup"
    fi
}

##########
## Basic Prompts
##
## {{{
function bare_prompt_setup()    { export PS1="${PROMPT_RETURN_CODE_TEXT}> "    ; unset ZSH_PROMPT; }
function plain_prompt_setup()   { export PS1="${PROMPT_RETURN_CODE_TEXT}%m> "  ; unset ZSH_PROMPT; }
function basic_prompt_setup()   { export PS1="${PROMPT_RETURN_CODE_TEXT}%n@%m> ";unset ZSH_PROMPT; }
## }}}

##########
## Debian-based Prompts
##
function my_prompt_1_setup()
{
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{%F{green}%n@%m%f:%F{blue}%~%f\$(git_prompt_info)
%}$retcode%% "
}
function my_prompt_2_setup()
{
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{[ %F{green}%n@%m%f | %F{blue}$~%f\$(git_prompt_info) ]
%}$retcode%% "
}

##########
## FancyPrompt1
##
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

# Source:
# http://nullcreations.net/entries/general/zsh-prompt-to-show-git-branch
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " (git:${ref#refs/heads/})"
}

function is_git_repo() { git status >/dev/null 2>/dev/null; echo $?                                 }
function git_branch()  { git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' }

##########
## Re-set the prompt or set the set the default prompt
##
test -n "$ZSH_PROMPT" || ZSH_PROMPT="basic_prompt"
set_prompt "$ZSH_PROMPT"

