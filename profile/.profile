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
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
##############################################################################


##############################################################################
# DEFINITIONS

# hostname
HOSTNAME="$(hostname)"
export HOSTNAME

# set tab size to 2
export SHELL_TAB_SIZE=2
tabs "$SHELL_TAB_SIZE"

# set my GPG key
export GPGKEY='0xF4B4A1414B2F9555'

# set lang
export LANG='en_US.UTF-8'
##############################################################################


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

# we source all the files in the folder ~/.profile.d, ending with *.profile
# shellcheck disable=SC1090
if [ -d ~/.profile.d/ ]; then
	for profile_file in ~/.profile.d/*.profile; do
	 # shellcheck disable=SC1090
	 source "$profile_file"
	done
fi
