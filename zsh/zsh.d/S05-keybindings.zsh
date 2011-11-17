
##########
## I have no clue what the purpose of this is. I'm just going to leave this
## here until I'm motivated to figure out what it's purpose is.
typeset -g -A key

##########
## EMACS BINDINGS
##    Though I prefer to use Vim as my editor, I prefer to use Emacs bindings
##    for my shells. I have no idea what the difference between 'bindkey -e'
##    and 'setopt- o emacs' is though (or if they are synonyms).
##
bindkey -e

##########
## I like my C-w to work like it does in vi/vim, so I set it to work like that,
## and set M-w to work like the default C-w.
##
bindkey '^W'  vi-backward-kill-word
bindkey 'w' backward-kill-word

