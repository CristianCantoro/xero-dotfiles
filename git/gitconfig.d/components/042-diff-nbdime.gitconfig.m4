[diff "jupyternotebook"]
	command = git-nbdiffdriver diff

[difftool "nbdime"]
	cmd = git-nbdifftool diff "$LOCAL" "$REMOTE" "$BASE"