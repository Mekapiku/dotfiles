DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .travis.yml .atom .rbenv .config
DOTFILES_TARGET_DIRS := .atom .rbenv .config
DOTFILES_TARGET   := $(wildcard .??*) bin .atom/config.cson .atom/init.coffee .atom/keymap.cson .atom/snippets.cson .atom/styles.less .rbenv/default-gems .config/karabiner/karabiner.json
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

deploy:
	@$(foreach val, $(DOTFILES_TARGET_DIRS), mkdir -p $(HOME)/$(val);)
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@$(foreach val, $(wildcard ./etc/init/enable/*.sh), bash -euvx $(val);)

all: deploy init
