""" Install manifest """

import glob
import os

homedir  = os.environ.get('HOME', os.path.expanduser('~'))
manifest = {
    'symlinks': [],
}

#=================
# Symlink all files/directories that look like 'filename.symlink' to
# '$HOME/.filename'. This would work even better if Python's native glob
# function supported double-glob (i.e. **/*.symlink) for traversing to
# arbitrary depth.

for linkable in glob.glob("*/*.symlink"):
    fname_base = linkable.split('/')[-1].split('.symlink')[0]
    target     = os.path.join(homedir, ".%s" % fname_base)
    source     = os.path.join(os.getcwd(), linkable)
    manifest['symlinks'].append((source, target))

#=================
# Symlink everything in bin/ directly into $HOME/bin/

def format_source(source): return os.path.join(os.getcwd(), source)
def format_target(target): return os.path.join(homeidr, target)

manifest['symlinks'] += [
    (
        format_source(item),
        format_target(os.path.join('bin', os.path.basename(item))
    )
    for item in glob.glob('bin/*')
]
