#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias home='cd ~'
alias build='sudo nixos-rebuild switch --flake ~/nixos-config'

# Make a timeshift snapshot
tsNow() {
	sudo timeshift --create --comment "$1"
}


# Automatically do an ls after each cd, z, or zoxide
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}


#Github
gcom() {
	git add .
	git commit -m "$1"
}

lazyg() {
	git add .
	git commit -m "$1"
	git push
}

# Searches for text in all files in the current folder
ftext() {
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Search for file with name
ffile() {
	sudo find / -name "$1"
}

rollback() {
	cd ~/nixos-config
	# Switch to the previous commit
	git checkout HEAD^1
	# Deploy the flake.nix located in the current directory,
	# with the nixosConfiguration's name `my-nixos`
	build
	cd -
}

pushConf() {
	cd ~/nixos-config
	lazyg $1
	cd -
}

clean() {
	nix-env --list-generations
	nix-collect-garbage  --delete-old
	# recommeneded to sometimes run as sudo to collect additional garbage
	sudo nix-collect-garbage -d
	# As a separation of concerns - you will need to run this command to clean out boot
	sudo /run/current-system/bin/switch-to-configuration boot
}

update() {
    cd ~/nixos-config
    nix flake update
    build
    cd -
}
