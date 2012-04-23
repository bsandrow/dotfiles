
autoload zsh/terminfo

ZSH_DEFAULT_PROMPT="basic_prompt"
ZSH_PROMPT_RETCODE_TEXT="%(0?..%F{red}%?%f )"

#-------------------------------------------------------------------------------
# Prompt Util Functions
#-------------------------------------------------------------------------------

# Switch Between Prompts
# ======================
function set_prompt()
{
    if [ -z "$1" ]; then
        echo "usage: set_prompt PROMPT"
        return 1
    fi

    ZSH_PROMPT="$1"

    # If a function named "${ZSH_PROMPT}_setup" exists, run it
    if type "${ZSH_PROMPT}_init" | grep -q 'shell function'; then
        eval "${ZSH_PROMPT}_init"
    fi
}

# Display the Chosen Prompt
# =========================
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

#-------------------------------------------------------------------------------
# Prompts
#-------------------------------------------------------------------------------

# Basic Prompts
# =============
function bare_prompt_init()    { export PS1="${ZSH_PROMPT_RETCODE_TEXT}> "    ; unset ZSH_PROMPT; }
function plain_prompt_init()   { export PS1="${ZSH_PROMPT_RETCODE_TEXT}%m> "  ; unset ZSH_PROMPT; }
function basic_prompt_init()   { export PS1="${ZSH_PROMPT_RETCODE_TEXT}%n@%m> ";unset ZSH_PROMPT; }

# Debian Inspired Prompt #1
# =========================
function debian_inspired_prompt_1_init()
{
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{%F{green}%n@%m%f:%F{blue}%~%f\$(git_prompt_info)
%}$retcode%% "
}

# Debian Inspired Prompt #2
# =========================
function debian_inspired_prompt_2_init()
{
    local retcode='$ZSH_PROMPT_RETCODE_TEXT'
    export PROMPT="%{[ %F{green}%n@%m%f | %F{blue}$~%f\$(git_prompt_info) ]
%}$retcode%% "
}

# Fancy Prompt
# ============
function fancy_prompt_init()
{
    local decor_start='%F{green}(%f'
    local decor_end='%F{green})%f'
    local divider='%F{green})-(%f'

    local host_part='%F{blue}%n@%M%f'
    local path_part='%F{yellow}%~%f'
    local time_part='%F{blue}%D{%Y/%m/%d %H:%M}%f'

    local good_retcode="%F{black}%K{green}:)%k%f"
    local bad_retcode="%F{white}%K{red}:(%k%f"

    local git_branch_display='$__GIT_BRANCH_FORMAT'

    export PROMPT="%{${decor_start}${host_part}${divider}${path_part}${divider}${time_part}${decor_end}${git_branch_display}
%}%F{green}%!%f %(0?.${good_retcode}.${bad_retcode}) "
}

function fancy_prompt_generator()
{
    __GIT_BRANCH_FORMAT=""

    if ! is_git_repo; then
        return
    fi

    local GIT_BRANCH_NAME=$(git_current_branch)
    export __GIT_BRANCH_FORMAT="%F{green}-(%fgit:%F{blue}${GIT_BRANCH_NAME:-<null>}%F{green})%f"
}
