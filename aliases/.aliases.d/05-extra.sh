#!/bin/bash
# Aliases

# BFG Repo-Cleaner
# https://rtyley.github.io/bfg-repo-cleaner/
if command -v java &>/dev/null && [ -f '/opt/BFG_repocleaner/bfg.jar' ]; then
  alias bfg='java -jar /opt/BFG_repocleaner/bfg.jar'
fi

# start a container with a clean instance of firefox
if command -v docker &>/dev/null; then
  function cleanfirefox() {
    docker run -d --rm \
               --network host \
               --shm-size 4g \
                 jlesage/firefox
  }
fi
