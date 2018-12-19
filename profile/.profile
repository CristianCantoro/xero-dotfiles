#!/usr/bin/env bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

##############################################################################
# Add ~/bin, ~/.local/bin to PATH
#
# set PATH so it includes user's private bin directories
# if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/usr/local/bin" ] && PATH="$HOME/usr/local/bin:$PATH"
[ -d "$HOME/usr/bin" ] && PATH="$HOME/usr/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
#############################################################################


# we source all the files in the folder ~/.profile.d, ending with *.profile
# shellcheck disable=SC1090
if [ -d ~/.profile.d/ ]; then
	for profile_file in ~/.profile.d/*.profile; do
	 # shellcheck disable=SC1090
	 source "$profile_file"
	done
fi


##############################################################################
# ALIASES
# source aliases for bash/zsh
if [ -d ~/.aliases.d ]; then
  # we need to loop over each file because source is ignoring each argumenta
  # after the first
	for alias_file in ~/.aliases.d/*.sh; do
	 # shellcheck disable=SC1090
	 source "$alias_file"
	done
fi
##############################################################################
