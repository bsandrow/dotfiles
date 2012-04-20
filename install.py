#!/usr/bin/env python

import imp
import os
import shutil
import sys

action_responses = {
    's': 'skip',
    'S': 'skip_all',
    'o': 'overwrite',
    'O': 'overwrite_all',
    'b': 'backup',
    'B': 'backup_all',
}

action_legend = """\
s: Skip this file.
S: Skip all files.
o: Overwrite this file.
O: Overwrite all files.
b: Backup this file (rename with '.backup' suffix).
B: Backup all files.
"""

manifest_file_default = 'manifest.py'

def paths_equal(path1, path2):
    """Fully resolve two file paths and compare them."""
    return os.path.realpath(path1) == os.path.realpath(path2)

def symlink(source, target):
    """Create a symlink, with a UI if the target already exists"""
    target_dir = os.path.dirname(target)
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    os.symlink(source, target)

def get_item_type(item):
    if os.path.islink(item):
        return "symlink"
    if os.path.isdir(item):
        return "directory"
    if os.path.isfile(item):
        return "file"
    return "unknown"

def prompt_for_action(target):
    """Prompt the user for an action"""
    print "A conflict exists for '%s':" % target
    print " + Error: %s exists!" % target

    target_type = get_item_type(target)
    print " + '%s' is a %s" % (target, target_type)

    if target_type == 'symlink':
        print " + pointing to: %s" % os.readlink(target)
        print " + which is a: %s" % get_item_type(os.readlink(target))

    action = raw_input("'%s' exists! Action (?/s/S/o/O/b/B)? " % target)
    while action not in action_responses:
        if action == '?':
            print action_legend
        else:
            print "Invalid input"
        action = raw_input("Action (s/S/o/O/b/B/?)? ")
    return action_responses[action]

def read_manifest(manifest_file):
    """Read in a manifest, and return a list of (src,dest) tuples"""
    fh = open(manifest_file, 'r')
    manifest = imp.load_module('<none>', fh, manifest_file, ('', 'r', imp.PY_SOURCE) )
    fh.close()
    return manifest.manifest

def bulk_process_symlinks(symlinks):
    action   = None
    for source, target in symlinks:
        if paths_equal(source, target):
            continue

        if os.path.lexists(target):
            if not (action and action.endswith('_all')):
                action = prompt_for_action(target)

            if action in ('skip','skip_all'):
                continue
            elif action in ('overwrite','overwrite_all'):
                # Note: the 'not islink()' is necessary because isdir() will return true if target
                #       is a symlink to a directory.
                if os.path.isdir(target) and not os.path.islink(target):
                    shutil.rmtree(target)
                else:
                    os.remove(target)
            elif action in ('backup','backup_all'):
                os.rename(target, "%s.backup" % target)
            else:
                sys.exit("Error: Invalid action: %s" % action)
        # endif

        symlink(source, target)

def main():
    manifest = read_manifest(manifest_file_default)
    bulk_process_symlinks(manifest.get('symlinks') or [])

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(">> Caught user interrupt. Exiting...")

# vim: set ft=python et sts=4 st=4 sw=4 tw=100:
