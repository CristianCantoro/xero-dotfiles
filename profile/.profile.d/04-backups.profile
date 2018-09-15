#!/usr/bin/env bash

##############################################################################
# RESTIC
#
# add restic env vars
# shellcheck disable=SC1090
[ -f "$HOME/.restic/environment" ] && \
  source "$HOME/.restic/environment"
##############################################################################

##############################################################################
# BUP
#
# add bup env vars
# shellcheck disable=SC1090
[ -f "$HOME/.bup/environment" ] && \
  source "$HOME/.bup/environment"
##############################################################################
