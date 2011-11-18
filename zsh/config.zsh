
#-------------------------
# Misc. Options
#-------------------------

setopt PROMPT_SUBST # Substitute variables in the $PS1 var (e.g. $HOME would get expanded)
setopt NOBEEP       # No more beeps! Huzzah! \o/

#-------------------------
# History
#-------------------------

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

#-------------------------
# LS_COLORS
#-------------------------
# Note: dircolors may not like all $TERM strings, so this may need to be
#       modified in the future.

if type dircolors >/dev/null 2>&1; then
    eval $(dircolors --bourne-shell)
fi
