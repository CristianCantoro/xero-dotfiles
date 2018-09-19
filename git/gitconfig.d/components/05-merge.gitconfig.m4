    ff = only
    # I pretty much never mean to do a real merge, since I use a rebase workflow.
    # Note: this global option applies to all merges, including those done during a git pull
    # https://git-scm.com/docs/git-config#git-config-mergeff

    conflictstyle = diff3
    # Standard diff is two sets of final changes. This introduces the original text before each side's changes.
    # https://git-scm.com/docs/git-config#git-config-mergeconflictStyle
