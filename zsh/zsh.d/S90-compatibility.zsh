##########
## When clearing the screen, just push the contents into the scrollback
## buffer, rather then completely eliminate them. Terminal emulators
## like xfce-terminal and gnome-terminal do this themselves, but xterm
## and urxvt don't.
##

function clear-screen() {
    zle -I
    # set to LINES-2 if prompt is only one line
    repeat $((LINES-1)) echo
    'clear'
}

zle -N clear-screen
alias clear="clear-screen"

##########
## csh compatibility
##
setenv() { export $1=$2 }

