#----------------------------------------
# Ack Grep
#----------------------------------------

function alias_ack()
{
    release_id=$(lsb_release --id | cut -d '	' -f 2)
    case $release_id in
        Ubuntu|Debian)
            ack_cmd="$(which ack 2> /dev/null)"
            if [ -x "$ack_cmd" ] && ack --version | grep -q 'Andy Lester'; then
                alias ack="ack"
            else
                alias ack="ack-grep"
            fi
            ;;
        *)
            alias ack="ack"
            ;;
    esac
}
alias_ack
