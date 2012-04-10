#-------------------------------------------------------------------------------
# SSH
#-------------------------------------------------------------------------------

# fixssh
# ======
#   This is paired with the grabssh script to allow refreshing of SSH
#   environment variables on stale remote shell sessions (i.e. detach screen
#   session an reattach from a new ssh connection). Note: $GRABSSH_DIR must be
#   set.
#
alias fixssh='if [ -f "${GRABSSH_DIR}/fixssh" ]; then source "${GRABSSH_DIR}/fixssh"; else echo "No ${GRABSSH_DIR}/fixssh found!"; fi'

# Tab-Completion
# ==============
source "$_/ssh-config-completion.bash"
