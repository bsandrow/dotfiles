

###########
# Find Ack
#
function find_ack() {
    # On Ubuntu/Debian the ack command is ack-grep in the repos, but we might also have installed
    # 'ack' from source into ~/bin. Check if 'ack' is the command we think it is, otherwise we use
    # ack-grep.
    if lsb_release --id | grep -iq 'ubuntu\|debian'; then
        if [ -x "$(which ack 2> /dev/null)" ] && ack --version | grep -q 'Andy Lester'; then
            echo "ack"
        else
            echo "ack-grep"
        fi
    else
        echo "ack"
    fi
}
alias ack='$(find_ack)'

# vim: set ft=sh et ts=4 sw=4 tw=100:
