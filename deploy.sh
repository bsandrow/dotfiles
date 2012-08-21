#!/bin/sh

PWD=$(pwd)

[ "$PWD" = "$HOME/.dotfiles" ] || ln -sfn "$PWD" "$HOME/.dotfiles"

for file in home/*; do
    dotfile=$(basename "$file")
    case "$dotfile" in
        Makefile|*.md|*.rst|LICENSE|setup.sh)
            ;;
        *)
            echo "Linking '$dotfile'..."
            ln -sfn "$PWD/$file" "$HOME/.$dotfile"
            ;;
    esac
done
