# launch scripts
.PHONY: default all clean
default: all
all: git

.PHONY: git
git: gitconfig
gitconfig: ./gitconfig.d/gitconfig.*.config
	@if [ -L '.gitconfig' ]; then\
		unlink '.gitconfig';\
	fi
	ln -s "./gitconfig.d/gitconfig.$$(hostname --short).config" '.gitconfig'

clean:
	rm -f gitconfig
