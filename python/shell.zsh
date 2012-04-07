#----------------------------------------
# Python
#----------------------------------------

### Environment

export PYPI_GPG_KEY=8FF63A1B
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME="$HOME/.virtualenv"

# If a virtualenv is already enabled, then this variable will be screwed up
# (using a python instance within a virtualenv is a no-no). We need to ensure
# that this is correct.
export VIRTUALENVWRAPPER_PYTHON=$(which -a python | grep -v "$WORKON_HOME" | head -1)

### Aliases

alias pydev="load_virtualenvwrapper"
alias pysh="python_shell"

### Functions

function python_shell()
{
    PYSHELL=${PYSHELL:-$(which ipython)}
    PYSHELL=${PYSHELL:-$(which python )}

    if [ -x "$PYSHELL" ]; then
        echo "Error: Could not find a Python interpreter!" >&2
        return 1
    fi

    $PYSHELL
}

function load_virtualenvwrapper()
{
    if [ $(lsb_release --id | cut -d '	' -f 2) = "Ubuntu" ]; then
        ubuntu_virtualenvwrapper="/etc/bash_completion.d/virtualenvwrapper"
        if [ -f "$ubuntu_virtualenvwrapper" ]; then
            source "$ubuntu_virtualenvwrapper"
        else
            echo "Warning: Could not find virtualenvwrapper setup: $ubuntu_virtualenvwrapper" >&2
        fi
    else
        source virtualenvwrapper
    fi
}
