##########
## Run dircolors to setup $LS_COLORS auto-magically (I guess this would also be
## the place to add my own customizations to $LS_COLORS if I had any).
##
type dircolors >/dev/null 2>&1 || return

# For some reason dircolors doesn't like some of these term strings. I'll just
# force it to see rxvt-unicode (which should give us the right output).
case "$TERM" in
    rxvt-unicode256|rxvt-unicode-256color)
        eval $(TERM=rxvt-unicode dircolors --bourne-shell)
        ;;
    *)
        eval $(dircolors --bourne-shell)
        ;;
esac
