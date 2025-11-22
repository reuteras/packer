#!/bin/bash
# Script for general user settings in virtual machines.

[[ ! -d ~/bin ]] && mkdir ~/bin
[[ ! -d ~/src ]] && mkdir ~/src

if [[ -e ~/.zshrc ]]; then
	if ! grep 'PATH' ~/.zshrc | grep "$HOME/bin" >/dev/null; then
		echo '' >>~/.zshrc
		echo "export PATH=\$PATH:$HOME/bin" >>~/.zshrc
	fi
fi

git clone https://github.com/reuteras/vmbin.git ~/src/vmbin
cp ~/src/vmbin/* ~/bin
rm -f ~/bin/README.md ~/bin/LICENSE
