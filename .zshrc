fpath=(${HOME}/.zsh/completion $fpath)

autoload colors
colors

autoload -Uz compinit
compinit

export LANG=ja_JP.UTF-8

PROMPT="
%{${fg[green]}%}[%d]%{${reset_color}%}
%U%n@%m%#%u "
PROMPT2="> "
if [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] ; then
PROMPT="
%{${fg[red]}%}[%d]%{${reset_color}%}
%U%n@%m%#%u "
fi
SPROMPT="%B%r is correct? [Yes, No, About, Edit]:%b "

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# すべてのバックグラウンドジョブを低優先度で実行を解除
unsetopt bg_nice

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
# to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

## Completion configuration
#
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
autoload -U compinit
compinit -u

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac

source ${HOME}/.zsh/zshrc.func
source-if-exists "${HOME}/.zsh/zshrc.alias"
source-if-exists "${HOME}/.zsh/zshrc.export"
source-if-exists "${HOME}/.zshrc.local"
source-if-exists "${HOME}/.zsh/git-info"
source-if-exists "${HOME}/.zsh/git-flow-completion.zsh"

case "${OSTYPE}" in
darwin*)
        source-if-exists "${HOME}/.zsh/zshrc.macos"
        ;;
linux*)
        source-if-exists "${HOME}/.zsh/zshrc.linux"
        ;;
esac

_Z_CMD=j
source-if-exists "${HOME}/.zsh/z.sh"
function precmd () {
    _z --add "$(pwd -P)"
}
compctl -U -K _z_zsh_tab_completion $_Z_CMD

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit
compinit

source-if-exists "$HOME/.pythonbrew/etc/bashrc"
source-if-exists "/usr/local/bin/aws_zsh_completer.sh"
source-if-exists "$HOME/.zsh/completion/gibo-completion.zsh"

PERL_MB_OPT="--install_base \"/Users/mot/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/mot/perl5"; export PERL_MM_OPT;

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
export PYENV_ROOT=/usr/local/opt/pyenv

if which plenv > /dev/null; then eval "$(plenv init -)"; fi

command_not_found_handler(){
  echo "$1: コマンドではない。"
}

source ~/.zsh/zsh-notify/notify.plugin.zsh

export PATH="$PATH:$HOME/.yarn/bin"
