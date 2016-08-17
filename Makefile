DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml .atom .rbenv
DOTFILES_TARGET_DIRS := .atom .rbenv
DOTFILES_TARGET   := $(wildcard .??*) bin bitbar .atom/config.cson .atom/init.coffee .atom/keymap.cson .atom/snippets.cson .atom/styles.less .rbenv/default-gems
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

deploy:
	@$(foreach val, $(DOTFILES_TARGET_DIRS), mkdir -p $(HOME)/$(val);)
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash -euvx $(val);)
