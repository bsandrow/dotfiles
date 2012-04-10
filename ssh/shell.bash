#-------------------------------------------------------------------------------
# SSH
#-------------------------------------------------------------------------------

# fixssh
# ======
#   This is paired with the grabssh script to allow refreshing of SSH
#   environment variables on stale remote shell sessions (i.e. detach screen
#   session an reattach from a new ssh connection).
#
alias fixssh='if [ -f "${HOME}/tmp/fixssh" ]; then source "${HOME}/tmp/fixssh"; else echo "No $HOME/tmp/fixssh found!"; fi'

# Tab-Completion
# ==============
source "$_/ssh-config-completion.bash"
