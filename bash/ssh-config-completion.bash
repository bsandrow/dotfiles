
# Bash-completion for ssh
# -----------------------
#
# The default bash completion for ssh hosts draws the completion items from the
# ~/.ssh/known_hosts file. There are a number of reasons why this fails. First,
# it's possible for people to use ~/.ssh/config to define shortcuts to hosts
# using the 'Host' directive. Secondly, many current linux distributions are
# setting the 'HashKnownHosts yes' option in /etc/ssh/ssh_config by default.
#
# This means that all of the hosts in known_hosts are hashed, and therefore
# unusable for completion. This solves that issue. Of course, it ignores any
# patterns defined in a 'Host' directive or entries that begin with a number.
#
# Sources:
#   * http://blog.zerodogg.org/2007/04/21/bash-ssh-host-completion/
#   * http://linuxjunk.blogspot.com/2007/02/ssh-bash-completion-in-ubuntu.html
#   * http://www.oddprocess.org/wp/2009/03/13/ssh-known_hosts-and-bash-completion/

complete -C \
"/usr/bin/perl -e '
my \$match = \$ARGV[1] ? \$ARGV[1] : \".*\";
open(my \$INPUT,\"<\$ENV{HOME}/.ssh/config\");
foreach(<\$INPUT>) {
    next unless s/^\s*Host\s+//;
    chomp;
    foreach(split(/\s+/)) {
        print \"\$_\\n\" if(/^\$match/ and not /^\d/ and not /\*/);
    }
}'" ssh

# Another version from the comments that doesn't look like it works correctly,
# namely, the /^\D/ pattern should be in after the split. In the original
# (above), the 'not /^\d/' is filtering on the already split apart arguments to
# the 'Host' line
#
#complete -C \
#"perl -le '
#\$p=qq#^\$ARGV[1]#;
#@ARGV=q#$HOME/.ssh/config#;
#/\$p/ 
#    && /^\D/
#    && not(/[*?]/)
#    && print for map { split/\s+/ } grep { s/^\s*Host(?:Name)?\s+//i } <>
#'" ssh
