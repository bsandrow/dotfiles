# vim:syn=zsh:

##########
## Python Shell - starts up an interactive python interpreter in a new
##   screen window, or in the current shell if not in a screen session.
##
function python_shell()
{
    if   [ -x "$(which ipython)" ]; then python_cmd="ipython"
    elif [ -x "$(which python)"  ]; then python_cmd="python"
    else
        echo "Error: Could not find a python interpreter"
        return 1
    fi

    if [ -n "$STY" ]; then
        screen -t "$python_cmd" "$python_cmd"
        unset python_cmd
        return $?
    else
        $python_cmd
        unset python_cmd
    fi
}
alias pysh="python_shell"

