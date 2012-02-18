#----------------------------------------
# Python
#----------------------------------------

### Python Shell

function python_shell()
{
    [ -x "$PYSHELL" ] || PYSHELL=$(which ipython)
    [ -x "$PYSHELL" ] || PYSHELL=$(which python)
    [ -x "$PYSHELL" ] || { echo "Could not find a Python interpreter!" >&2; return 1; }

    $PYSHELL
}
alias pysh="python_shell"

### Virtual Env

export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME="$HOME/.virtualenv"

if [ $(lsb_release --id | cut -d '	' -f 2) = "Ubuntu" ]; then
    ubuntu_virtualenvwrapper="/etc/bash_completion.d/virtualenvwrapper"
    if [ -f "$ubuntu_virtualenvwrapper" ]; then
        source "$ubuntu_virtualenvwrapper"
    fi
fi
