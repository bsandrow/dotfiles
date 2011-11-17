
# Somehow this ended up in my zshrc. I've seen it in a lot of other zshrcs, and
# I think that the 'key' array is a way to direcly set keybindings, but I'm not
# motivated enough to track this down.
#
#typeset -g -A key

#---------------
# Bindings Mode
#---------------
#
#  Though I prefer to use Vim as my editor, I prefer to use Emacs bindings for
#  my shells. I have no idea what the difference between 'bindkey -e' and
#  'setopt- o emacs' is though (or if they are synonyms).
#
bindkey -e

#-------------------
# Use Vim-style C-w
#-------------------
#
# I like having more granularity in my C-w binding. I've remapped the default
# C-w binding to M-w because sometimes there are string with way too many
# special characters that I just want to quickly axe.
#
bindkey '^W'  vi-backward-kill-word
bindkey 'w' backward-kill-word

