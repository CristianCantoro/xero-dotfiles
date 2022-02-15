    prune = fetch --prune
    # Because I constantly forget how to do this
    # https://git-scm.com/docs/git-fetch#git-fetch--p

    undo = reset --soft HEAD^
    # Not quite as common as an amend, but still common
    # https://git-scm.com/docs/git-reset#git-reset-emgitresetemltmodegtltcommitgt

    stash-all = stash save --include-untracked
    # We wanna grab those pesky un-added files!
    # https://git-scm.com/docs/git-stash

    # show me the changes in patch format in a stash
    stashed = stash show -p

    glog = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
    # No need for a GUI - a nice, colorful, graphical representation
    # https://git-scm.com/docs/git-log
    # via https://medium.com/@payload.dd/thanks-for-the-git-st-i-will-use-this-4da5839a21a4

    graph = log --graph --color --pretty=format:"%C(yellow)%H%C(green)%d%C(reset)%n%x20%cd%n%x20%cn%x20(%ce)%n%x20%s%n"

    # aliases for status (I always mistype status)
    stat = status
    stats = status -sb

    last = log -1 --stat

    unstage = reset HEAD --

    cached = diff --cached
