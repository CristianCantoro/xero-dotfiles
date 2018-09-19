# launch scripts
.PHONY: default all clean
default: all
all: gitconfig

DOTFILES_GIT_CONFIG ?= $(HOSTNAME)

ifeq ($(tmpdir),)

location = $(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
self := $(location)

get_tmpdir:
	@tmpdir=$(shell mktemp --tmpdir -d 'tmp.dotfiles.git.XXXXXX'); \
	trap 'rm -rf "$$tmpdir"' EXIT; \
	$(MAKE) -f $(self) --no-print-directory tmpdir=$$tmpdir $(MAKECMDGOALS)

gitconfig: get_tmpdir

else

git: gitconfig
gitconfig: ./gitconfig.d/gitconfig.$(DOTFILES_GIT_CONFIG).m4 ./gitconfig.d/components/*.gitconfig.m4
	@echo "Running target $(MAKECMDGOALS) with $(tmpdir)"
	m4 -I./gitconfig.d/components/ \
  ./gitconfig.d/gitconfig.$(DOTFILES_GIT_CONFIG).m4 > ${tmpdir}/gitconfig
	cat -s ${tmpdir}/gitconfig > gitconfig
	cp -v gitconfig ~/.gitconfig

endif

clean:
	rm -f gitconfig
