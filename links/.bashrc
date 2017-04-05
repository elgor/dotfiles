


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# General Setting
# ============================================================


# Lokale setzen
export LANG=de_DE.UTF-8
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
#PATH=$HOME/Software/gnatarm/bin:$PATH
PATH=$HOME/Software/gnatpro/bin:$PATH
PATH=$HOME/.local/bin:$PATH
PATH=$PATH:$HOME/scripts
PATH=$PATH:/home/emu/Software/stlink
PATH=$HOME/.rvm/rubies/ruby-2.3.3/bin:$PATH
export PATH

# if no interactive shell, exit
[ -z "$PS1" ] && return

# if using with cygwin, fix link behavior 
CYGWIN=winsymlinks:nativestrict

# fzf?
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# tests
#function joinstr { local IFS="$1"; shift; echo "$*"; }
#function fcd { cd $(joinstr \* $(echo "$*" | fold -w1))* }


# check for fish
# command -v fish >/dev/null && exec fish

# load promptheus theme
source ~/.promptheusrc

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
