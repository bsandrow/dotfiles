##########
## Sets the terminal title. Selects from a preset list of
## TERM_TITLE_STRINGs, or just jams the function args into the
## TERM_TITLE_STRING variable.
##
set_term_title()
{
    case "$1" in
        term_title_1)
            export TERM_TITLE_STRING="/dev/%l - %n@%m"
            ;;
        *)
            export TERM_TITLE_STRING="$@"
            ;;
    esac
}

##########
## Display the terminal title if the $TERM_TITLE_STRING value is set.
## Make sure to preserve the return value of the previous command
## executed in the shsll.
##
display_term_title()
{
    local retval=$?
    local xterm_title_start=$'\e]0;'
    local xterm_title_end=$'\a'

    [ "$TERM" = "linux" ] && return $retval
    [ -n "$TERM_TITLE_STRING" ] \
        && print -Pn "%{${xterm_title_start}${TERM_TITLE_STRING}${xterm_title_end}%}"
    return $retval
}

##########
## Add display_term_title to be run prior to every prompt (but only if
## it's not already in the list).
##
if [[ -z "${precmd_functions[(R)display_term_title]}" ]]; then
    precmd_functions+='display_term_title'
fi
