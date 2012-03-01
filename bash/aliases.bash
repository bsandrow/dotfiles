#---------------------------------------
# Aliases
#---------------------------------------

alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lss='ls -sh'
alias llt='ls -lt'
alias lltr='ls -ltr'
alias grepc='grep --color=auto'
alias egrepc='egrep --color=auto'
alias pst='ps -u $USER wwf'
alias clear='COUNT=$((LINES)); while [[ $COUNT -gt 0 ]]; do echo; COUNT=$((COUNT-1)); done; unset COUNT; clear'

# Note: The --group-directories-first option is newer and may need to be
#       disabled on systems running an older ls (or non-gnu systems)
alias dir='ls --format=vertical --group-directories-first'
alias vdir='ls --format=long --group-directories-first'
