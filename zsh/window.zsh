#----------------------------------------
# XTerm Title Functions
#----------------------------------------
#  This system allows for use of ZShell's special string expansion vars within
#  an XTerm title. The value of $XTERM_TITLE will be run through 'print -P'
#  (thereby expanding the %-vars) after every command.

function set_term_title()
{
    case "$1" in
        default)
            export XTERM_TITLE="/dev/%l - %n@%m"
            ;;
        *)
            export XTERM_TITLE="$@"
            ;;
    esac
}

function display_term_title()
{
    local retval=$?
    local title_start=$'\e]0;'
    local title_end=$'\a'

    # A $TERM value of 'linux' is *usually* reserved for Linux VTs which don't
    # have any titles to set.
    if [ "$TERM" = "linux" ]; then
        return $retval
    fi

    if [ -n "$XTERM_TITLE" ]; then
        print -Pn "%{${title_start}${XTERM_TITLE}${title_end}%}"
    fi

    return $retval
}

# Make this refresh after every command
if [[ -z "${precmd_functions[(R)display_term_title]}" ]]; then
    precmd_functions+='display_term_title'
fi

#----------------------------------------
# Clear Screen
#----------------------------------------
#  When clearing the screen, just push the contents into the scrollback
#  buffer, rather then completely eliminate them. Terminal emulators
#  like xfce-terminal and gnome-terminal do this themselves, but xterm
#  and urxvt don't.
#
function clear-screen() {
    zle -I
    # set to LINES-2 if prompt is only one line
    repeat $((LINES-1)) echo
    'clear'
}

zle -N clear-screen
alias clear="clear-screen"
