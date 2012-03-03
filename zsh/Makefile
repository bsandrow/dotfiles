
zshrc.symlink: zshrc.*.in *.zsh ../*/*.zsh
	echo                   > zshrc.symlink
	cat "zshrc.header.in" >> zshrc.symlink
	cat *.zsh             >> zshrc.symlink
	find .. -path '../zsh' -prune -o -name '*.zsh' -print | while read file; do\
        echo ""       >> zshrc.symlink &&\
        cat  "$$file" >> zshrc.symlink; \
    done
	echo                  >> zshrc.symlink
	cat "zshrc.footer.in" >> zshrc.symlink
