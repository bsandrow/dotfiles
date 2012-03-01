#---------------------------------------
# Prompt
#---------------------------------------

#term color escape sequences
GREEN="\e[32m"
GREEN="\033[32m"
GREEN_BOLD="\e[32;1m"
BLUE="\e[34m"
BLUE_BOLD="\e[34;1m"
RED="\e[31m"
RED_BOLD="\e[31;1m"
RESET_COLORS="\e[0m"

#dynamic term title escape sequences
t_start="\[\033]0;"
t_end="\007\]"
#t_start="\[\e]0;"
#t_end="\a\]"

# eval_title
# ----------
# This is a prevantative measure. We'll leave the title empty if we're in a
# screen session. This prevents the 'race condition' of both bash and screen
# trying to set the xterm title, and bash always wins. We'll use the
# $BASH_DONT_CLOBBER_SCREEN variable to enable/disable this behavior.

function eval_title()
{
    # the option is turned off
    [ -z "$BASH_DONT_CLOBBER_SCREEN" ] && { echo -n "$1"; exit; }

    # we're not in screen
    [ -z "$STY" ] && { echo -n "$1"; exit; }

    echo -n ""
}

function check_svn()
{
    work_dir="$1"
    if [ -d "$work_dir/.svn" ]; then
        return 0
    else
        return 1
    fi
}

function check_git()
{
    work_dir="$1"
    while [ "$work_dir" != "/" ]
    do
        if [ -d "$work_dir/.git" ]; then
            return 0
        fi
        work_dir=`dirname "$work_dir"`
    done
    return 1
}

# default_debian_prompt
# ---------------------
# This is just a straight up rip-off of the standard debian/ubuntu prompt line.
# I've obviously added a couple of features. (like not clobbering screen)

function debian_default_prompt()
{
    title=`eval_title "\[\e]0;\u@\h: \w\a\]"`
    if [ -z "$BASH_USE_COLOR_PROMPT" ]; then
        export PS1="$title"'${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    else
        export PS1="$title"'${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    fi
}

# default_debian_remix
# --------------------
# This is my 'remix' of the default debian prompt. Note that something doesn't
# like it when \] comes *after* \n instead of before it (i.e. \n\] causes a
# weird character on screen).

function debian_default_remix()
{
    retval=$?
    title=`eval_title "\[\e]0;\u@\h: \w\a\]"`
    if [ $retval -eq 0 ]; then
        retval=""
    else
        retval="\[${RED_BOLD}\]${retval}\[${RESET_COLORS}\]"
    fi
    if [ -z "$BASH_USE_COLOR_PROMPT" ]; then
        export PS1="$title"'\[${debian_chroot:+($debian_chroot)}\u@\h:\w\]\n% '
    else
        export PS1="$title"'\[${debian_chroot:+($debian_chroot)}'"${GREEN}\u@\h${RESET_COLORS}:${BLUE}\w${RESET_COLORS}\]\n${retval}% "
    fi

}

# Simple Prompt 1
# ---------------
# Just a simple prompt that I like to use for remote hosts, I would trim it
# down to just '> ', but I would lose the information reminding me of which
# host I'm on.

function simple_prompt_1()
{
    export PS1='\h> '
}

# Simple Prompt 2
# ---------------
# Just another simple prompt that shows the username too.

function simple_prompt_2()
{
    export PS1='\u@\h> '
}

# Topbar Prompt 1
# ---------------
# A prompt with a topbar on it.

function topbar_prompt_1()
{
    RETURN_VAL=$?
    PS1=""
    rcs_type=''

    # If I ever end up in 'sh' then I don't have to worry about garbage
    if [ -z "$BASH_VERSION" ]; then
        export PS1="`hostname`> "
        return
    fi
    # dynamic title for x11 terms
    #case TERM in
    #    xterm*)
    #    rxvt*)
    #        echo -e "$t_start${USER}@${HOSTNAME}:${PWD//$HOME/~}$t_end"
    #        ;;
    #esac

    # add in the RCS type
    check_svn "$PWD" && rcs_type="${GREEN}svn${RESET_COLORS} | "
    check_git "$PWD" && rcs_type="${GREEN}git${RESET_COLORS} | "

    # add the info line
    PS1="$PS1\[[ ${GREEN}$USER@`hostname`${RESET_COLORS} | $rcs_type$GREEN${PWD/$HOME/~}$RESET_COLORS ]\]\n"

    # add the prompt (dependent on return value)
    if [ $RETURN_VAL -ne 0 ]; then
        PS1="$PS1\[$RED\]$RETURN_VAL\[$RESET_COLORS\]> "
    else
        PS1="$PS1> "
    fi

    export PS1
}


function topbar_prompt_2()
{
    RETURN_VAL=$?
    PS1=""

    # If I ever end up in 'sh' then I don't have to worry about garbage
    if [ -z "$BASH_VERSION" ]; then
        export PS1="`hostname`> "
        return
    fi

    # add the info line
    PS1="$PS1\[ ${BLUE_BOLD}`date +%H:%M`${RESET_COLORS} :: ${BLUE_BOLD}$USER @ `hostname`${RESET_COLORS} :: ${BLUE_BOLD}${PWD/$HOME/~}${RESET_COLORS} \]\n"

    # add the prompt (dependent on return value)
    if [ $RETURN_VAL -ne 0 ]; then
        PS1="$PS1\[$RED\]$RETURN_VAL\[$RESET_COLORS\]> "
    else
        PS1="$PS1> "
    fi

    export PS1
}

# Topbar Prompt 3
# ---------------
# This one adds the git branch name and the 'git' after the path

function topbar_prompt_3()
{
    RETURN_VAL=$?
    PS1=""
    rcs_type=''

    # If I ever end up in 'sh' then I don't have to worry about garbage
    if [ -z "$BASH_VERSION" ]; then
        export PS1="`hostname`> "
        return
    fi

    # add in the RCS type
    check_svn "$PWD" && rcs_type="svn"
    check_git "$PWD" && rcs_type="git"

    # add the info line
    PS1="$PS1\[[ ${GREEN}$USER@`hostname`${RESET_COLORS} | $BLUE${PWD//$HOME/~}$RESET_COLORS "
    if [ "$rcs_type" = 'git' ]; then
        PS1="$PS1$(__git_ps1 "(%s)") "
    elif [ "$rcs_type" = 'svn' ]; then
        PS1="$PS1(svn) "
    fi
    PS1="$PS1$RESET_COLORS]\]\n"

    # add the prompt (dependent on return value)
    if [ $RETURN_VAL -ne 0 ]; then
        PS1="$PS1\[$RED\]$RETURN_VAL\[$RESET_COLORS\]> "
    else
        PS1="$PS1> "
    fi

    export PS1
}

PROMPT_COMMAND=topbar_prompt_3
