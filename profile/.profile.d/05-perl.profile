#!/usr/bin/env bash

##############################################################################
# PERL
#
# Perl modules
# shellcheck disable=SC2086
PERL='/usr/bin/perl'
export PERL
if [ -d "$HOME/perl5" ]; then
  export PERL5LIB="$HOME/perl5/"
  eval "$(perl -I"$HOME/perl5/lib/perl5" -Mlocal::lib)"
fi
