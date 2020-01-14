[merge "jupyternotebook"]
	driver = git-nbmergedriver merge %O %A %B %L %P
	name = jupyter notebook merge driver

[mergetool "nbdime"]
	cmd = git-nbmergetool merge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
