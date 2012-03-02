#---------------------------------------
# Prompt
#---------------------------------------

# ANSI Term Color Escape Sequences
#
green="\e[32m"
green_bold="\e[32;1m"
blue="\e[34m"
blue_bold="\e[34;1m"
red="\e[31m"
red_bold="\e[31;1m"
reset="\e[0m"

# XTerm Title Escape Sequences
#
t_start="\[\033]0;"
t_end="\007\]"

# Choose a Prompt
#
PROMPT_COMMAND=topbar_prompt

#-------------------
# Prompt Helpers
#-------------------

# eval_title
# ----------
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

function is_in_svn_repo()
{
    if [ -d "$PWD/.svn" ]; then
        return 0
    else
        return 1
    fi
}

function is_in_git_repo()
{
    dir="$PWD"
    while [ "$dir" != "/" ]
    do
        if [ -d "$dir/.git" ]; then
            return 0
        fi
        dir=$(dirname $dir)
    done
    return 1
}

#-------------------
# Prompt Setup
#-------------------

# Default Debian
# --------------
# This is just a straight up rip-off of the standard debian/ubuntu prompt line.
# I've obviously added a couple of features. (like not clobbering screen)

function debian_default_prompt()
{
    title=$(eval_title "\[\e]0;\u@\h: \w\a\]")

    if [ -z "$BASH_USE_COLOR_PROMPT" ]; then
        export PS1="$title"'${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    else
        export PS1="$title"'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    fi
}

# Default Debian (Remix)
# ----------------------
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
# -------------

function simple_prompt()
{
    export PS1='\u@\h> '
}

# Topbar Prompt
# -------------

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

    if is_in_git_repo; then
        REPO_STR=$(printf "git:%s" "$(__git_ps1 "%s")")
    elif is_in_svn_repo; then
        REPO_STR="svn"
    fi

    if [ $RETURN_VAL -ne 0 ]; then
        RETURN_VAL_STR=$(printf "\[$red\]%s\[$reset\]" "$RETURN_VAL")
    fi

    if [ -n "$REPO_STR"]; then
        export PS1="\[[ $HOST_STR | $DIRECTORY_STR | $REPO_STR ]\]\n$RETURN_VAL_STR \!>"
    else
        export PS1="\[[ $HOST_STR | $DIRECTORY_STR ]\]\n"
    fi

    unset HOST_STR DIRECTORY_STR REPO_STR RETURN_VAL_STR
}

