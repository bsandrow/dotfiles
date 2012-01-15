### Python Shell
#
#  Launch an interactive Python shell.
#
function python_shell()
{
    [ -x "$PYSHELL" ] || PYSHELL=$(which ipython)
    [ -x "$PYSHELL" ] || PYSHELL=$(which python)
    [ -x "$PYSHELL" ] || { echo "Could not find a Python interpreter!" >&2; return 1; }

    $PYSHELL
}

alias pysh="python_shell"

export VIRTUAL_ENV_DISABLE_PROMPT=1

# vim: set filetype=sh:
