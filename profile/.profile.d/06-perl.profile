#!/usr/bin/env bash

##############################################################################
# PERL
#
# Perl modules

export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
eval "$(perl -I"$HOME"/perl5/lib/perl5 -Mlocal::lib="$HOME"/perl5)"

if [ -f "$HOME/perl5/perlbrew/etc/bashrc" ]; then
  source "$HOME/perl5/perlbrew/etc/bashrc"
fi
