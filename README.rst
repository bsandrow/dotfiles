========
dotfiles
========

Installation
------------

To install: ::

    $ git clone 'git://github.com/bsandrow/dotfiles.git' ~/.dotfiles
    $ cd ~/dotfiles
    $ git submodule init && git submodule update
    $ ./deploy.sh

This will symlink everything in `home/` to `~/.filename`. Note: This will
*overwrite* any pre-existing files or directories.

Credits
-------

Copyright 2012 Brandon Sandrowicz <brandon@sandrowicz.org>. Licensing terms
should be found in LICENSE.

vim:ft=rst
