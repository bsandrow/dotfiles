dotfiles
========

These are my dotfiles. They are installed like so:

    git clone git://github.com/bsandrow/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./install

The install script requires a Python interpreter. It will probably work at least
on Python 2.6+, but may work all the way back to Python 2.3.

You'll notice that, for the most part, some of the configuration has been split
up by topic. I took that approach from (Zach Holman)[https://github.com/holman/dotfiles/].
This means that my main shell configurations are under zsh/ and bash/, but
aliases / environment variables that are topic-specific end up in their own
directories.

For example, the ack/ directory contains not only the .ackrc file, but also
shell files to setup an alias used to normalize the command name differences
across platforms (ack vs ack-grep).

.symlink files
==============

Anything with a .symlink extention will get symlinked into $HOME by the install
script. E.g.

    zsh/zshrc.symlink is symlinked to ~/.zshrc
    vim/vim.symlink is symlinked to ~/.vim

bin/ directory
==============

The path ~/.dotfiles/bin is explicitly specitified to be in the `$PATH`
variable, so there is no need to symlink it to $HOME/bin. Topic-specific
scripts should be in the topic directories, with a symlink in bin/. E.g.:

    $ ls -l ~/.dotfiles/bin/git-wtf
    lrwxrwxrwx 1 bjs bjs 14 2011-12-01 07:36 /home/bjs/.dotfiles/bin/git-wtf -> ../git/git-wtf

Credits
=======

This repository is a combination of 3rd party packages under permissive
licenses, and my own code which is Copyright 2011 Brandon Sandrowicz.

Everything copyrighted by me is under the license terms in LICENSE. Everything
else should have license terms inline in the files, if not notify me and I'll
sort something out (either adding the license terms myself, or creating a
manifest linking files/packages to license terms).
