# A nice little github-like colorful, split diff right in the console.
# via http://owen.cymru/github-style-diff-in-terminal-with-icdiff/
[diff]
     tool = icdiff

[difftool]
     prompt = false

[difftool "icdiff"]
    cmd = /usr/local/bin/icdiff --line-numbers $LOCAL $REMOTE

