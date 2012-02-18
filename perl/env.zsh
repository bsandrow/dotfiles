#----------------------------------------
# Perl
#----------------------------------------

### Perlbrew Setup

perlbrew_bashrc="$HOME/perl5/perlbrew/etc/bashrc"
if [ -f "$perlbrew_bashrc" ]; then
    source "$perlbrew_bashrc"
fi
