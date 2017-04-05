# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt autocd
setopt extendedglob
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data




bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/emu/.zshrc'

autoload -Uz compinit
compinit
autoload -U colors
colors
# End of lines added by compinstall

source ~/.promptheusrc


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
