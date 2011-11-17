# http://xanana.ucsc.edu/~wgscott/wordpress_new/wordpress/?p=12
# New to zsh 4.3.4+

autoload -U is-at-least

##########
## Reset the arrays first. Just in case we reload the setup in the middle of a
## login, I don't want to have things in the arrays twice.
##
## I may want to disable this at some point. Currently, I'm switching over all
## of the setup functions that add to these arrays to check for existence
## first, so that they don't blindly add duplicates.
##
test -n "$preexec_functions" && unset preexec_functions
test -n "$precmd_functions"  && unset precmd_functions
test -n "$chpwd_functions"   && unset chpwd_functions

##########
## Setup the functions
##
test -n "$preexec_functions" || typeset -ga preexec_functions
test -n "$precmd_functions"  || typeset -ga precmd_functions
test -n "$chpwd_functions"   || typeset -ga chpwd_functions

##########
## Backwards Compatibility
##
## Support for the {preeexec,chpwd,precmd}_functions were added in
## 4.3.4. If we are using a prior version of Zsh, then we need to use
## this hack to emulate it.
##
is-at-least 4.3.4 || {
    function preexec() # {{{
    {
        for func in $preexec_functions
        do
            eval $func
        done
    } # }}}

    function precmd() # {{{
    {
        for func in $precmd_functions
        do
            eval $func
        done
    } # }}}

    function chpwd() # {{{
    {
        for func in $chpwd_functions
        do
            eval $func
        done
    } # }}}
}

# vim:fdm=marker
