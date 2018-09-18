#!/usr/bin/env bash

##############################################################################
# DEFINITIONS

# hostname
HOSTNAME="$(hostname)"
export HOSTNAME

# source host-specific configurations
# shellcheck disable=SC1090
if [ -f ~/.dotfiles_profile ]; then
  source ~/.dotfiles_profile

  # set the defaults here
  if [ -z "${DOTFILES_HOSTGROUP+x}" ]; then
  	DOTFILES_HOSTGROUP="$HOSTNAME"
  	export DOTFILES_HOSTGROUP
  fi

  if [ -z "${DOTFILES_THEME_COLORING+x}" ]; then
  	DOTFILES_THEME_COLORING="$DOTFILES_HOSTGROUP"
  	export DOTFILES_THEME_COLORING
  fi

  if [ -z "${DOTFILES_SSH_CONFIG+x}" ]; then
    DOTFILES_SSH_CONFIG="$DOTFILES_HOSTGROUP"
    export DOTFILES_SSH_CONFIG
  fi

  if [ -z "${DOTFILES_HOSTS_CONFIG+x}" ]; then
    DOTFILES_HOSTS_CONFIG="$DOTFILES_HOSTGROUP"
    export DOTFILES_HOSTS_CONFIG
  fi
fi

# set tab size to 2
export SHELL_TAB_SIZE=2
tabs "$SHELL_TAB_SIZE"

# set my GPG key
export GPGKEY='0xF4B4A1414B2F9555'

# set lang
export LANG='en_US.UTF-8'
