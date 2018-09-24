# Stolen from:
#   * https://blog.scottnonnenberg.com/better-git-configuration
#   * https://gist.github.com/scottnonnenberg/fefa3f65fdb3715d25882f3023b31c29
[user]
    email = cristian@balist.es
include(01-user.gitconfig.m4)

[credential]
include(02-credential.gitconfig.m4)

[alias]
include(03-alias.gitconfig.m4)

[color]
include(04-color.gitconfig.m4)

[merge]
include(05-merge.gitconfig.m4)

[commit]
define(GPGSIGN, false)dnl
include(06-commit-sign.gitconfig.m4)

[push]
include(07-push.gitconfig.m4)

[status]
include(08-status.gitconfig.m4)

[transfer]
include(09-transfer.gitconfig.m4)

include(11-gpg.gitconfig.m4)
