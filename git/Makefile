# launch scripts
.PHONY: default all clean
default: all
all: git

.PHONY: git
git: gitconfig
gitconfig: ./gitconfig.d/gitconfig.*.config
	ln -s "./gitconfig.d/gitconfig.$$(hostname).config" '.gitconfig'

clean:
	rm -f gitconfig
