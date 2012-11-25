# Author: Oleg Selivanov <oleg.a.selivanov@gmail.com>

install: .vimrc .zshrc
	for dotfile in .vimrc .zshrc ; do \
	  ln -sf $$(realpath $$dotfile) ~/$$dotfile ; \
	done

