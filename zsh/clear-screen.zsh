# Clear Screen
# ~~~~~~~~~~~~
#
#   When clearing the screen, just push the contents into the scrollback
#   buffer, rather then completely eliminate them. Terminal emulators like
#   xfce-terminal and gnome-terminal do this themselves, but xterm and urxvt
#   don't.
#
function clear-screen()
{
    zle -I

    if $(echo ${PROMPT:-$PS1} | wc -l) -eq 2; then
        repeat $((LINES-1)) echo
    else
        repeat $((LINES-2)) echo
    fi

    'clear'
}

zle -N clear-screen
alias clear="clear-screen"

# vim:ft=zsh
