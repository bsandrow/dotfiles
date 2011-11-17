# vim:syn=zsh:
#
# Customizations for working with GNU Screen
#

##########
## SSH Window - Launch a new screen window with the title set to the
##   host we're connecting to. Make sure that we suck in a bunch of
##   variables that might be local to the current shell, but not set
##   (correctly) in the global screen session.
##
function new_ssh_screen_window()
{
    if [ -n "$STY" ]; then
        screen -t "$1" \
            env \
                SSH_CLIENT="$SSH_CLIENT" \
                SSH_TTY="$SSH_TTY" \
                SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
                SSH_CONNECTION="SSH_CONNECTION" \
                DISPLAY="$DISPLAY" \
                ssh "$@"
        return 0
    else
        echo "Not in a screen session!" >&2
        return 1
    fi
}
alias sshs='new_ssh_screen_window'

##########
## Screen Title - Use escape codes to attempt to set the screen title.
##   This doesn't always work due to permissions on writing to a screen
##   session.
##
set_screen_title() { echo -ne "]83;title '$1'" }
alias scrnttl='set_screen_title $(hostname)'
