#-------------------------------------------------------------------------------
# Prompt Helpers
#-------------------------------------------------------------------------------

# ANSI Colors
# ===========
     green="\e[32m"
green_bold="\e[32;01m"
      blue="\e[34m"
 blue_bold="\e[34;01m"
       red="\e[31m"
  red_bold="\e[31;01m"
     reset="\e[00m"

# XTerm Title
# ===========
t_start="\[\033]0;"
  t_end="\007\]"

# eval_title
# ==========
# This is a prevantative measure. We'll leave the title empty if we're in a
# screen session. This prevents the 'race condition' of both bash and screen
# trying to set the xterm title, and bash always wins. We'll use the
# $BASH_DONT_CLOBBER_SCREEN variable to enable/disable this behavior.
function eval_title()
{
    if [ -n "$BASH_DONT_CLOBBER_SCREEN" -a -n "$STY" ]; then
        return
    fi

    echo -n "$1"
}

# is_svn_repo
# ===========
function is_svn_repo()
{
    DIR=${1:-$PWD}
    test -d "$DIR/.svn"
    return $?
}

# is_git_repo
# ===========
function is_git_repo()
{
    DIR="${1:-$PWD}"
    while [ "$DIR" != "/" ]; do
        if [ -d "$DIR/.git" ]; then
            return 0
        fi
        DIR=$(dirname $DIR)
    done
    return 1
}

#-------------------------------------------------------------------------------
# Prompts
#-------------------------------------------------------------------------------

# Default Debian
# ==============
# This is just a straight up rip-off of the standard debian/ubuntu prompt line.
# I've obviously added a couple of features. (like not clobbering screen)

function debian_default_prompt()
{
    title=$(eval_title "\[\e]0;\u@\h: \w\a\]")

    if [ -z "$BASH_USE_COLOR_PROMPT" ]; then
        export PS1="$title\${debian_chroot:+(\$debian_chroot)}\u@\h:\w\\$ "
    else
        export PS1="$title\${debian_chroot:+(\$debian_chroot)}\[$green_bold\]\u@\h\[$reset\]:\[$blue_bold\]\w\[$reset\]\\$ "
    fi
}

# Default Debian (Remix)
# ======================
# This is my 'remix' of the default debian prompt. Note that something doesn't
# like it when \] comes *after* \n instead of before it (i.e. \n\] causes a
# weird character on screen).

function debian_default_remix()
{
    retval=$?
    title=$(eval_title "\[\e]0;\u@\h: \w\a\]")

    if [ $retval -eq 0 ]; then
        retval=""
    else
        retval="\[$red_bold\]$retval\[$reset\]"
    fi

    if [ -z "$BASH_USE_COLOR_PROMPT" ]; then
        export PS1="$title"'\[${debian_chroot:+($debian_chroot)}\u@\h:\w\]\n% '
    else
        export PS1="$title"'\[${debian_chroot:+($debian_chroot)}'"$green\u@\h$reset:$blue\w$reset\]\n$retval% "
    fi

}

# Simple Prompt
# =============

function simple_prompt()
{
    export PS1='\u@\h> '
}

# Topbar Prompt
# =============

function topbar_prompt()
{
    RETURN_VAL=$?

    # If I ever end up in 'sh' then I don't have to worry about garbage on the
    # prompt
    if [ -z "$BASH_VERSION" ]; then
        export PS1="$(hostname -s)> "
        return
    fi

    local HOST_STR=$(printf "$green%s@%s$reset" $USER $(hostname -s))
    local DIRECTORY_STR=$(printf "$blue%s$reset" "${PWD//$HOME/~}")
    local REPO_STR=""
    local RETURN_VAL_STR=""

    if is_git_repo; then
        REPO_STR=$(printf "git:%s" "$(__git_ps1 "%s")")
    elif is_svn_repo; then
        REPO_STR="svn"
    fi

    if [ $RETURN_VAL -ne 0 ]; then
        RETURN_VAL_STR=$(printf "\[$red\]%s\[$reset\] " "$RETURN_VAL")
    fi

    if [ -n "$REPO_STR" ]; then
        export PS1="\[[ $HOST_STR | $DIRECTORY_STR | $REPO_STR ]\]\n$RETURN_VAL_STR\!% "
    else
        export PS1="\[[ $HOST_STR | $DIRECTORY_STR ]\]\n$RETURN_VAL_STR\!% "
    fi

    unset HOST_STR DIRECTORY_STR REPO_STR RETURN_VAL_STR
}

