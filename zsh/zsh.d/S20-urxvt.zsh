
##########
## Only Process if we are a URXVT terminal
##
case $TERM in
    rxvt*|urxvt*)
        ;;
    *)
        if [ "$TERM" = "screen" ] && [ -z "$COLORFGBG" ]; then
            return
        fi
        ;;
esac

bindkey '^?'        backward-delete-char
bindkey '^[[1~'     beginning-of-line
bindkey '^[[4~'     end-of-line
bindkey '^[[5~'     up-line-or-history
bindkey '^[[3~'     delete-char
bindkey '^[[6~'     down-line-or-history
bindkey '^[[A'      up-line-or-search
bindkey '^[[D'      backward-char
bindkey '^[[B'      down-line-or-search
bindkey '^[[C'      forward-char
bindkey '^[[2~'     overwrite-mode
bindkey '^[[1;5C'   forward-word
bindkey '^[[1;5D'   backward-word
#bindkey '^[[7~'     beginning-of-line
#bindkey '^[[8~'     end-of-line



