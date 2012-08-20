# Prompt
# ======

# Setup
# ~~~~~
PROMPT_COMMAND='topbar_prompt'
BASH_USE_COLOR_PROMPT=1
BASH_DONT_CLOBBER_SCREEN=1

# ANSI Colors
# ~~~~~~~~~~~
green="\e[32m"
green_bold="\e[32;01m"
blue="\e[34m"
blue_bold="\e[34;01m"
red="\e[31m"
red_bold="\e[31;01m"
reset="\e[00m"

# Helpers
# ~~~~~~~
function xterm_title() {
    if [ -n "$DONT_CLOBBER_SCREEN_TITLE" ]; then
        is_screen_session && return
        is_tmux_session   && return
    fi

    local TITLE_START="\[\033]0;"
    local TITLE_END="\007\]"

    echo -n "${title_start}$*${title_end}"
}

function is_git_repo() {
    dir="${1:-$PWD}"
    dirname=$(dirname "$dir")

    [ -d "$dir/.git" ]   && return 0
    [ "$dirname" = "/" ] && return 1

    is_git_repo "$dirname"
    return $?
}

function is_svn_repo()
{
    DIR=${1:-$PWD}
    test -d "$DIR/.svn"
    return $?
}

# Prompts
# ~~~~~~~
#
# Debian Default Prompt:
#       title=$(xterm_title "\u@\h: \w")
#       export PS1="\[$title\]\${debian_chroot:+(\$debian_chroot)}\[$green_bold\]\u@\h\[$reset\]:\[$blue_bold\]\w\[$reset\]\\$ "
#       
# Debian Default Remix:
#       [ $? -ne 0 ] && retval="\[$red_bold\]$retval\[$reset\]"
#       title=$(xterm_title "\u@\h: \w")
#       export PS1="\[$title\]"'\[${debian_chroot:+($debian_chroot)}'"$green\u@\h$reset:$blue\w$reset\]\n$retval% "
#
# Simple Prompt:
#       export PS1='\u@\h> '
#

function topbar_prompt()
{
    [ $? -ne 0 ] && RETURN_VAL_STR=$(printf "\[$red\]%s\[$reset\] " "$RETURN_VAL")
    [ -z "$BASH_VERSION" ] && export PS1="$(hostname -s)> " && return

    local HOST_STR=$(printf "$green%s@%s$reset" $USER $(hostname -s))
    local DIRECTORY_STR=$(printf "$blue%s$reset" "${PWD//$HOME/~}")
    local REPO_STR=""
    local RETURN_VAL_STR=""

    if is_git_repo; then
        REPO_STR=$(printf "git:%s" "$(__git_ps1 "%s")")
    elif is_svn_repo; then
        REPO_STR="svn"
    fi

    if [ -n "$REPO_STR" ]; then
        export PS1="\[[ $HOST_STR | $DIRECTORY_STR | $REPO_STR ]\]\n$RETURN_VAL_STR\!% "
    else
        export PS1="\[[ $HOST_STR | $DIRECTORY_STR ]\]\n$RETURN_VAL_STR\!% "
    fi

    unset HOST_STR DIRECTORY_STR REPO_STR RETURN_VAL_STR
}

