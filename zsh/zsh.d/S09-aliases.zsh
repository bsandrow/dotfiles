##########
## Aliases
##
alias ls='ls --color=auto'
alias ll='ls -l'
alias llt='ls -lt'
alias lla='ls -lA'
alias lss='ls -sh'
alias grep='grep --color=auto'
alias gvr='gvim --servername `hostname` --remote-silent'
alias sandbox='{ test -d $HOME/sandbox || mkdir -p $HOME/sandbox; } && cd $HOME/sandbox'
alias dotfiles='{ test -d $HOME/projects/dotfiles && cd $HOME/projects/dotfiles; } || echo "No dotfiles checkout @ $HOME/projects/dotfiles"'

# Fix ssh environment variables in remote screen sessions. The 'fixssh' file is
# created by another script which exports all of the environment variables that
# need to be updated in the screen session.
#
# [ When you detach a remote screen session and reattach from a new ssh
# connection, some of the environment vars used for things like ssh-agent
# forwarding are not updated. These need to be exported to a eval'able file
# from the new login shell, before ssh is attached. Then all shells in the ssh
# session can just run 'fixssh' to import the updated env var values. ]
alias fixssh='if [ -f "${HOME}/tmp/fixssh" ]; then source "${HOME}/tmp/fixssh"; else echo "No $HOME/tmp/fixssh found!"; fi'
