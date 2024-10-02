define(`HOSTNAME', esyscmd(`printf \`\`%s\'\' "$HOSTNAME"'))dnl
define(`USER', esyscmd(`printf \`\`%s\'\' "$USER"'))dnl
# Stolen from:
#   * https://blog.scottnonnenberg.com/better-git-configuration
#   * https://gist.github.com/scottnonnenberg/fefa3f65fdb3715d25882f3023b31c29
[user]
    email = USER@HOSTNAME
include(001-user.gitconfig.m4)

[credential]
include(010-credential.gitconfig.m4)

[alias]
include(020-alias.gitconfig.m4)

[color]
include(030-color.gitconfig.m4)

[merge]
include(060-merge.gitconfig.m4)

[commit]
define(GPGSIGN, false)dnl
include(070-commit-sign.gitconfig.m4)

[push]
include(080-push.gitconfig.m4)

[status]
include(090-status.gitconfig.m4)

[transfer]
include(100-transfer.gitconfig.m4)

include(041-icdiff.gitconfig.m4)
include(050-gpg.gitconfig.m4)
