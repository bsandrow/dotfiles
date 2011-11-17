prefix ?= $(HOME)

.PHONY: default install copy

default: install

install:
	install -d -m 755 $(prefix) $(prefix)/bin $(prefix)/.zsh.d
	[ ! -e zlogin   ] || install -m 644 zlogin   $(prefix)/.zlogin
	[ ! -e zprofile ] || install -m 644 zprofile $(prefix)/.zprofile
	[ ! -e zlogout  ] || install -m 644 zlogout  $(prefix)/.zlogout
	[ ! -e zshenv   ] || install -m 644 zshenv   $(prefix)/.zshenv
	[ ! -e zshrc    ] || install -m 644 zshrc    $(prefix)/.zshrc
	install -m 755 -t $(prefix)/bin    bin/*
	install -m 644 -t $(prefix)/.zsh.d zsh.d/*

copy:
	install -d -m 755 $(prefix)
	cp -a bin zlogin zprofile zshenv zshrc zsh.d $(prefix)/
