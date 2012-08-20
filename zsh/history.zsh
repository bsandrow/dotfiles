# History
# ~~~~~~~

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt SHARE_HISTORY        # Share history across sessions
setopt HIST_IGNORE_SPACE    # commands starting w/ a space don't go into history

# SHARE_HISTORY seems to imply both of these, at least that's how the manpage
#   reads, so let's comment them out for now.
#
# setopt INC_APPEND_HISTORY   # Incrementally append history to file
# setopt EXTENDED_HISTORY     # Save the timestamp and duration of commands to history file

# vim:ft=zsh
