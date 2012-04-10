#-------------------------------------------------------------------------------
# Perl
#-------------------------------------------------------------------------------

# Aliases
# =======
alias perldev='init_perlbrew'

# Perlbrew Setup
# ==============
function perlbrew_init()
{
    perlbrew_bashrc="$HOME/perl5/perlbrew/etc/bashrc"
    if [ -f "$perlbrew_bashrc" ]; then
        source "$perlbrew_bashrc"
    fi
}
