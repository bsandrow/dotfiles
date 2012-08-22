# Colors
# ------

# Color Escapes
# ~~~~~~~~~~~~~
#   Easy access to all of the common escape codes for manipulating console text
#   display, including 256-color settings.
#
#   SOURCE: https://bitbucket.org/pfrischmuth/zshrc-darwin/raw/c10b4f065214/colors.zsh
#
typeset -Ag FG BG FX

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
    reset-fg  "%{[39m%}" reset-bg     "%{[49m%}" # Set the foreground or background to default
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

FG[reset]="%{[39m%}"
BG[reset]="%{[49m%}"
FG[default]="%{[39m%}"
BG[default]="%{[49m%}"


# dircolors
# ~~~~~~~~~
[ -x $(which dircolors 2>/dev/null) ] && eval $(dircolors --bourne-shell)

# vim:ft=sh
