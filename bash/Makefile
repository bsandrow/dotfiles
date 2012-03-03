
bashrc.symlink: bashrc.*.in *.bash ../*/*.bash
	echo                    > bashrc.symlink
	cat "bashrc.header.in" >> bashrc.symlink
	cat *.bash             >> bashrc.symlink
	find .. -path '../bash' -prune -o -name '*.bash' -print | while read file; do\
        echo ""       >> bashrc.symlink &&\
        cat  "$$file" >> bashrc.symlink; \
    done
	echo                   >> bashrc.symlink
	cat "bashrc.footer.in" >> bashrc.symlink
