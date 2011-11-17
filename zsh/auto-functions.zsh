#----------------------------------------
# Auto-Arrays
#----------------------------------------
#  These arrays contain lists of shell function names that are meant to be
#  execute at specific files. Traditionally these were just functions that one
#  could define, but zsh added the ability to just add them to an array in
#  4.3.4, which will be auto-matically run through.

#--------------------
# Reset Arrays
#--------------------
#  This prevents us from running into issues when re-sourcing our config from a
#  running shell.

test -n "$preexec_functions" && unset preexec_functions
test -n "$precmd_functions"  && unset precmd_functions
test -n "$chpwd_functions"   && unset chpwd_functions

#--------------------
# Initialize
#--------------------

test -n "$preexec_functions" || typeset -ga preexec_functions
test -n "$precmd_functions"  || typeset -ga precmd_functions
test -n "$chpwd_functions"   || typeset -ga chpwd_functions

#--------------------
# Old Versions
#--------------------
#  These auto-parsed arrays didn't show up until zsh 4.3.4, so we need to
#  create some make-shift ones for older versions of zsh.

autoload -U is-at-least

if is-at-least '4.3.4'; then
    ;
else
    function preexec()
    {
        for func in $preexec_functions; do
            eval $func
        done
    }

    function precmd()
    {
        for func in $precmd_functions; do
            eval $func
        done
    }

    function chpwd()
    {
        for func in $chpwd_functions; do
            eval $func
        done
    }
fi

#----------------------------------------
# Attribution
#----------------------------------------
#
# [1] http://xanana.ucsc.edu/~wgscott/wordpress_new/wordpress/?p=12

# vim: set ft=zsh et sts=4 st=4 sw=4 fdm=marker
