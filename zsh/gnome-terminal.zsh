# GNOME Terminal
# ~~~~~~~~~~~~~~

function running_in_gnome_terminal()
{
    # Note: This only works if the shell is a direct child process of a
    #       gnome-terminal instance. Things like screen, tmux or ssh will cause
    #       this to fail. The true purpose of this is to make sure that the initial
    #       shell that gnome-terminal spawns can set TERM=xterm-256color
    #       because there is no easy facility for this in GNOME Terminal's preferences.

    parent_process=$PPID
    ps -e | grep 'gnome-terminal' | while read line; do
        clean_line=$(echo "$line" | sed -e 's/^[[:space:]]\+//' -e 's/[[:space:]]\+/ /g')

        process_id=$(echo "$clean_line" | cut -d' ' -f1)
        if [ "$process_id" = "$parent_process" ]; then

            process_name=$(echo "$clean_line" | cut -d' ' -f4)
            if [ "$process_name" = "gnome-terminal" ]; then
                return 0
            fi
        fi
    done
    return 1
}

if [ "$TERM" = "xterm" ] && running_in_gnome_terminal; then
    export TERM=xterm-256color
fi
