# ==========================================================================================
# Promptheus v1.0 von Emanuel Regnath        ©2011 - 2016
# 
# Brief: Shell settings and prompt theme for bash  
#
# Features:
# - Time
# - User name with color indication for root user
# - path of working directory with color indication for write access
# - Error code if last command is not successful
# ==========================================================================================

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
export PATH

# if no interactive shell, exit
[ -z "$PS1" ] && return


# if using with cygwin, fix link behavior 
CYGWIN=winsymlinks:nativestrict

# CDPATH: search path for the cd command. This is a colon-separated 
#         list of directories IN which cd will look for matches
# export CDPATH=~/Dropbox:~/ownCloud



# Alias
# --------------------------------->
alias ..='cd ..'; alias ...='cd ../..'; alias ....='cd ../../..'
alias cd..='cd ..'

alias ls='dirinfo; ls -BC --color=always --group-directories-first'   #| more -f
alias sl='ls'

alias ll='ls -lGah --time-style=+"%y-%m-%d %R"'

# file manipulation
alias rm='rm -i'
#alias cp='cp -u'
alias mv='mv -i'



alias du='du -sh'     # disk usage is human
alias df='df -h'      # disk freespace is human

alias grep='grep --color=auto'

alias ff='find . | grep -i'    # find file
alias fif='grep -InH -r'        # find in fil

alias x='extract'       # x=eXtract <Datei>
alias o='xdg-open'




##############################################################################
# check shell
##############################################################################
if test -n "$ZSH_VERSION"; then
  PROFILE_SHELL=zsh
elif test -n "$BASH_VERSION"; then
  PROFILE_SHELL=bash
elif test -n "$KSH_VERSION"; then
  PROFILE_SHELL=ksh
elif test -n "$FCEDIT"; then
  PROFILE_SHELL=ksh
elif test -n "$PS3"; then
  PROFILE_SHELL=unknown
else
  PROFILE_SHELL=sh
fi


if test -n "$BASH_VERSION"; then
  export SHELL=$(which bash)
  # set VI key bindings
  set -o vi
  isBash=true
  USER_SYMBOL="\u"
  HOST_SYMBOL="\h"
  TIME_SYMBOL="\A"
  UMARK="\\\$"
elif test -n "$ZSH_VERSION"; then
  # set VI key bindings
  bindkey -v
  export KEYTIMEOUT=2
  zle -N zle-keymap-select
  zle -N zle-line-init
  isBash=false
  USER_SYMBOL="%n"
  HOST_SYMBOL="%m"
  TIME_SYMBOL="%T"
  UMARK="%(!.#.%%)" 
  TITLEBAR=""

zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="(CMD)"
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}

else
	# Basic SH, short version
	export PS1="┌─╸$(date +%H:%M)╺─◆─┤ $(pwd) ├─■
└─┤ $(id -u -n) "
	return
fi

#check TTY
TTY_PATH=$(tty)
TTY_PATH=${TTY_PATH:5}

# Fensterüberschrift setzen aber nur wenn das Terminal nicht die Systemconsole ist
#[ "$TERM" = "linux" ] && TITLEBAR="" || TITLEBAR="\[\033]0;\u@\h on $TTY_PATH\007\]"
[ "$TERM" = "xterm" ] && export TERM="xterm-256color" #Farbsupport


# check for git
export GIT_INFO=''
command -v git  >/dev/null && {
  export GIT_INFO="git_branch"
  GIT_BRANCH_SYMBOL='⑂'
  GIT_BRANCH_CHANGED_SYMBOL='+'
  GIT_NEED_PUSH_SYMBOL='⇡'
  GIT_NEED_PULL_SYMBOL='⇣' 
} 


# check for svn support
export SVN_INFO=''
command -v svn  >/dev/null && {
  export SVN_INFO="svn_branch"
  SVN_BRANCH_SYMBOL='⚡'
}


# -------------------------------------------------------------------
# (Bash) Shell options
if $isBash; then
  # Die History-Einstellungen verbessern
  HISTCONTROL=ignoredups:ignorespace
  HISTSIZE=1000
  HISTIGNORE="[   ]*:&:bg:fg:ls:exit:ls *:find .:history"
  export HISTSIZE HISTIGNORE HISTCONTROL

  shopt -s histappend
  shopt -s no_empty_cmd_completion 
  shopt -s cdspell        # fix dir-name typos in cd
  shopt -s autocd # cd to dirname
  shopt -s checkwinsize   # handle xterm resizing
  shopt -s cmdhist        # save multi-line commands as one line
  shopt -s dotglob        # allow tab-completion of '.' filenames
  shopt -s hostcomplete   # tab-complete words containing @ as hostnames
  shopt -s execfail # failed execs don't exit shell
  set -o notify           # show status of terminated programs immediately

  # Bash sudo completion
  complete -cf sudo

  complete -o nospace -o filenames -F fuzzypath cd ls cat
else
  setopt HIST_IGNORE_DUPS
  setopt autocd     # auto cd to dir
  setopt LIST_PACKED

  # compdef fuzzypath cd
  
  zstyle ':completion:*' completer _complete _match _approximate
  zstyle ':completion:*:approximate:*' max-errors 2 numeric
  zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}'
fi


# cd with ls
#function cd {
#    builtin cd "$@" && ls -AB --color=always --group-directories-first
#}#



CDHISTORY_FILE="$HOME/.cdhist" 
CDHIST_MAX=30

function inCdHist(){
  rx=".*${1//\//.*\/}[^/]*"
  echo -e "$(\grep -ix $rx $CDHISTORY_FILE | sed "s|$PWD/||")"
}

function appCD(){
  [ -f $CDHISTORY_FILE ] && touch $CDHISTORY_FILE
  cdhist=''
  while IFS='' read -r line || [[ -n "$line" ]]; do
    [[ $line != $PWD ]] && cdhist="${cdhist}\n$line"
  done < $CDHISTORY_FILE
  cdhist="$PWD${cdhist}"
  echo -e ${cdhist} | head -n $CDHIST_MAX > $CDHISTORY_FILE
}


function jumpToDir(){
  #rx="$(echo $1 | sed 's|.|\\(.*/\\)?\0|g')[^/]*"
  rx="([^.]*/)?${1/\//\\(.*/\\)}[^/]*"
  # echo "rx: $rx"
  IFS=$'\t\n'
  histdirs=( $(inCdHist $1) )
  for hdir in ${histdirs}; do  # cheat for shell compatibility
    if [[ -d "${hdir}" ]] ; then
      builtin cd "${hdir}"
      appCD 
    fi
    return 
  done
  searchdir=$(find * -maxdepth 2 -type d -regextype posix-egrep -iregex ${rx} -print -quit)
  #echo "Search: $dir"
  if [[ -d $searchdir ]] ; then 
    builtin cd $searchdir
    appCD
  else
    echo "No directory found for \"$1\""
  fi  
}



function myip(){
  echo "todo"
}

function cd(){
  builtin cd $1 &> /dev/null
  if [[ $? -eq 0 ]] ; then
    appCD
  else
    jumpToDir $1
  fi
}

# only in bash
function fuzzypath() { # $1 is command, $2 is arg
  if [ -z $2 ] ;then
    COMPREPLY=( `\ls -A` )
  else
    DIRPATH=$(echo $2 | sed 's/[^/]*$//')
    BASENAME=`echo $2 | sed 's/.*\///'`
    rx=$(echo ${BASENAME} | sed 's|.|\0.*|g')
    [ -z $rx ] && rx='.+'
    #echo "dir: $DIRPATH"
    #echo "file: $BASENAME"
    dirs=()
    IFS=$'\t\n'
    if [[ -z $DIRPATH ]] ; then
      dirs=( $(find * -maxdepth 0 -type d -iregex "$rx" -print) )
    elif [[ -d $DIRPATH ]] ; then
      dirs=( $(find ${DIRPATH//\\ / } -maxdepth 1 -type d -iregex "${DIRPATH}$rx" -print) )
    fi
    ## search history
    if [[ -z "$dirs" ]] ; then
      rx=".*${2//\//.*\/}[^/]*"
      dirs=( $(\grep -ix $rx $CDHISTORY_FILE | sed "s|$PWD/||") )
      #echo "${dirs[*]}"
    fi
    unset $IFS
    COMPREPLY=( ${dirs[*]} )
  fi
}




# Override lame default apps with useful 3rd-party ones if they exist
command -v pinfo >/dev/null && alias info=$(which pinfo)
command -v htop >/dev/null && alias top=$(which htop)
command -v colormake >/dev/null && alias make=$(which colormake)
command -v colordiff >/dev/null && alias diff=$(which colordiff)
command -v colorgcc >/dev/null && alias gcc=$(which colorgcc)
command -v colorsvn >/dev/null && alias svn=$(which colorsvn)




# Define Colors
# --------------------------------->
if $isBash; then
  white="\[\033[0;37m\]"; WHITE="\[\033[1;37m\]"
  blue="\[\033[0;34m\]"; BLUE="\[\033[1;34m\]"
  green="\[\033[0;32m\]"; GREEN="\[\033[1;32m\]"
  cyan="\[\033[0;36m\]"; CYAN="\[\033[1;36m\]"
  red="\[\033[0;31m\]"; RED="\[\033[1;31m\]"
  purple="\[\033[0;35m\]"; PURPLE="\[\033[1;35m\]"
  yellow="\[\033[0;33m\]"; YELLOW="\[\033[1;33m\]"
  GRAY="\[\033[1;30m\]"
else
  white="%{$fg_no_bold[white]%}"; WHITE="%{$fg_bold[white]%}"
  blue="%{$fg_no_bold[blue]%}"; BLUE="%{$fg_bold[blue]%}"
  green="%{$fg_no_bold[green]%}"; GREEN="%{$fg_bold[green]%}"
  cyan="%{$fg_no_bold[cyan]%}"; CYAN="%{$fg_bold[cyan]%}"
  red="%{$fg_no_bold[red]%}"; RED="%{$fg_bold[red]%}"
  purple="%{$fg_no_bold[magenta]%}"; PURPLE="%{$fg_bold[magenta]%}"
  yellow="%{$fg_no_bold[yellow]%}"; YELLOW="%{$fg_bold[yellow]%}"
  GRAY="%{$fg_bold[black]%}"
fi


# Color Settings
# --------------------------------->
cline="${cyan}" # Farbe der Verzierung
ctime="${cyan}"
cgit="${GRAY}"
cnone="${white}"
cuser="${YELLOW}"
croot="${PURPLE}"
cwdirw="${GREEN}" # Farbe für Verzeichnis mit Schreibrechten
cwdiruw="${cyan}" # Farbe für Verzeichnis ohne Schreibrechte

main_color="${cyan}";
emph_color="${YELLOW}";
pos_color="${GREEN}";
neg_color="${red}";

COLOR_COMMAND=${WHITE}
COLOR_BASHRC_DEFINED=${BLUE}
COLOR_NOT_INSTALLED=${GRAY}
COLOR_DEFAULT=${white}

# if root-login change userfarbe.
[ $UID -eq 0 ] && cuser=${croot}

# set LS_COLORS
[ -f ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" 


# Put the hostname if not locally connected
# else diplay the host without color
# The connection is not expected to change from inside the shell, so we
# build this just once
HOST_INFO=""
_lp_connection()
{
    if [[ -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY" ]] ; then
        # If we are connected with a X11 support
        if [[ -n "$DISPLAY" ]] ; then
          echo "${GREEN}@${cnone}$(hostname)"
        else
          echo "${cnone}@$(hostname)"
        fi
    else
        local sess_parent="$(ps -o comm= -p $PPID 2> /dev/null)"
        if [[ "$sess_parent" = "su" || "$sess_parent" = "sudo" ]] ; then
            echo su   # Remote su/sudo
        fi
    fi
}
HOST_INFO="$(_lp_connection)"
unset _lp_connection


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Welcome Message
# ============================================================
echo -en "   \033[0;33m
  ██     ██  ███     ██  ███  ███     ███
  ██     ██  ██ ██   ██         ███ ███
  ██     ██  ██  ██  ██  ███      ███
  ██     ██  ██   ██ ██  ███    ███ ███
  █████████  ██     ███  ███  ███     ███
\033[0;37m
  Where there is a shell, there is a way!

┌─ Login-Info ────────────────────────────┐
│                                         │
\033[s│Date:   $(date "+%a  %x - %R") \033[u\033[42C│
\033[s│User:   ${USER}@$(hostname) \033[u\033[42C│
\033[s│Memory: \033[m\033[38;5;2m"$(( $(sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo)/1024))"\033[38;5;22m/"$(($(sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo)/1024 ))MB" \033[u\033[42C\033[0;37m│
\033[s│Uptime: $(uptime | sed "s/.*up \+\([^,]*\), .*/\1/") \033[u\033[42C│
└─────────────────────────────────────────┘
"


function _short_path()
{
  # short path
  PWD=$(pwd)
  wdir=${PWD/#$HOME/\~}         #/home/user durch ~ ersetzen

  local -i len=${#wdir}
  local -i maxlen=${COLUMNS}-18
  
  #check writing permission
  [ -w "$(pwd)" ] && cwdir=${cwdirw} || cwdir=${cwdiruw}
  
  # if it fits
  if [[ ${#wdir} -le $maxlen ]]; then
    echo $wdir; return
  fi

  # finds all the '/' in the path and stores their positions
  local pos
  pos=()
  local slashes=0
  if $isBash; then INDEX_START=0; else INDEX_START=1; fi
  local -i i=$INDEX_START
  for ((i=0;i<len;i++)); do
    if [[ "${wdir:$i:1}" == / ]]; then
      pos=(${pos[@]} $i)
      let slashes++        
    fi
  done

  # calculate max displayed chars for each level
  lastdir="/${wdir##*/}"
  lastdirlen=${#lastdir}
  eachlen=$(( (${maxlen}-$lastdirlen-1) / ($slashes-1) -1))  # length including /
  #echo "${maxlen}, $slashes, $lastdirlen, $eachlen, "

  # dirname: "${s%/*}"
  # basename "${s##*/}"
  
  if [[ $eachlen -le 1 ]]; then
    eachlen=2
    restlen=$(( (${maxlen}-2) - (${eachlen}+1)*($slashes-1) ))
    [[ $restlen -le 2 ]] && restlen=2
    lastdir="${lastdir:0:$restlen}…"
  fi

  newpwd="${wdir:0:${pos[INDEX_START]}}"
  for ((i=$INDEX_START;i<slashes-1+$INDEX_START;i++))
  do
    local folderlen=$((${pos[i+1]}-${pos[i]}))
    if [[ ${folderlen} -gt $((${eachlen}+1)) ]]; then
      newpwd+="${wdir:${pos[i]}:$eachlen}…"
    else
      newpwd+="${wdir:${pos[i]}:$folderlen}"
    fi
  done
  newpwd+="${lastdir}"

  echo $newpwd
}


function _color_path(){
  [ -w "$1" ] && path_color="${pos_color}" || path_color="${main_color}"
  echo "${path_color}${1//\//${emph_color}/${path_color}}"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# The Prompt
# ============================================================



# Prompt-Funktion:
function custom_prompt_command()
{
  retval=$?  # get return value of last command
  [[ retval -ne 0 ]] && ERROR_CODE="${red}Error: ${retval}" || ERROR_CODE=""

  # append last command to history NOW (crash-safe)
  # history -a

  # short wdir to fit window
  wdir=$(_short_path)

  # Change wdir color according to write permission
  [ -w "$(pwd)" ] && cwdir=${pos_color} || cwdir=${main_color}
  wdir="${cwdir}${wdir//\//${emph_color}/${cwdir}}"
  #wdir=$(_color_path "${wdir}")

  ## Ladies and gentlemen, $PS1 ##
  PS1="$TITLEBAR${ERROR_CODE}
${cline}┌─╸${ctime}${TIME_SYMBOL}${cline}╺─◆─┤ ${wdir} ${cline}├─■
${cline}└─┤${USER_SYMBOL}${HOST_INFO}${cuser}${UMARK} ${white}${cgit}$(${GIT_INFO})$(${SVN_INFO})${cnone}"

  PS2="${cline}└◆┤${white} "
}

# Befehl ausführen
if $isBash; then
  PROMPT_COMMAND=custom_prompt_command
else
  function precmd { 
  	RPROMPT=""
    print -Pn "\e]0;%n@%m\a"   # what is this?
    custom_prompt_command 
  }
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Own Functions
# ============================================================


# print infos about the current dir
function dirinfo()
{
  afiles=$(find . -maxdepth 1 | wc -l)
  hfiles=$(find . -maxdepth 1 -name ".*" | wc -l)
  sfiles=$(($afiles-$hfiles))
  echo "$(($afiles-1)) objects, ${sfiles} visible, $(($hfiles-1)) hidden:"
}


# GIT #

# Show Informations in GIT Repo
git_branch() { 
    # try to get current branch or or SHA1 hash for detached head
    local branch="$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
    if [ -z "$branch" ]; then 
      echo -n ""
      return  # not a git branch
    fi

    local marks

    # branch is modified
    [ -n "$(git status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

    # check if local branch is ahead/behind of remote and by how many commits
    # Shamelessly copied from http://stackoverflow.com/questions/2969214/git-programmatically-know-by-how-much-the-branch-is-ahead-behind-a-remote-branc
    local remote="$(git config branch.$branch.remote)"
    local remote_ref="$(git config branch.$branch.merge)"
    local remote_branch="${remote_ref##refs/heads/}"
    local tracking_branch="refs/remotes/$remote/$remote_branch"
    if [ -n "$remote" ]; then
        local pushN="$(git rev-list $tracking_branch..HEAD|wc -l|tr -d ' ')"
        local pullN="$(git rev-list HEAD..$tracking_branch|wc -l|tr -d ' ')"
        [ "$pushN" != "0" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$pushN"
        [ "$pullN" != "0" ] && marks+=" $GIT_NEED_PULL_SYMBOL$pullN"
    fi

    # print the git branch segment without a trailing newline
    echo -n "$GIT_BRANCH_SYMBOL$branch$marks "
}



# SUBVERSION #

# Get the branch name of the current directory
# For the first level of the repository, gives the repository name
svn_branch()
{
    local root
    local url
    local branch
    eval $(LANG=C LC_ALL=C svn info 2>/dev/null | sed -n 's/^URL: \(.*\)/url="\1"/p;s/^Repository Root: \(.*\)/root="\1"/p' )
    if [[ "$root" == "" ]]; then
        return
    fi


    # other method
    # svn_branch=`svn info | grep '^URL:' | egrep -o '((tags|branches)/[^/]+|trunk).*' | sed -E -e 's/^(branches|tags)\///g'`
    # svn_repository=`svn info | grep '^Repository Root:' | egrep -o '(http|https|file|svn|svn+ssh)/[^/]+' | egrep -o '[^/]+$'`
    # svn_version=`svnversion -n`


    # Make url relative to root
    url="${url:${#root}}"
    if [[ "$url" == */trunk* ]] ; then
        branch="trunk"
    elif [[ "$url" == */branches/?* ]] ; then
        url="${url##*/branches/}"
        branch="${url%/*}"
    elif [[ "$url" == */tags/?* ]] ; then
        url="${url##*/tags/}"
        branch="${url%/*}"
    else
        branch="${root##*/}"
    fi

    local changes
    changes=$(( $(svn status | grep -c -v "?") ))
    if [[ $changes -eq 0 ]] ; then
        echo -n "${SVN_BRANCH_SYMBOL}${branch} "
    else
        echo -n "${SVN_BRANCH_SYMBOL}${branch}($changes) " # changes to commit
    fi
}


# ------------------------------------------------------------
# dirdiff : Show the difference between the contents of two directories.
#           Non-recursive.
dirdiff () {
        diff -yB -W 80 <(ls -1 --color=never $1) <(ls -1 --color=never $2)
}


# extracts all kinds of archives
function extract()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1     ;;
      *.tar.gz)    tar xvzf $1     ;;
      *.tar)       tar xvf $1      ;;
      *.tbz2)      tar xvjf $1     ;;
      *.tgz)       tar xvzf $1     ;;
      *.bz2)       bunzip2 $1      ;;
      *.rar)       unrar x $1      ;;
      *.gz)        gunzip $1       ;;
      *.zip)       unzip $1        ;;
      *.Z)         uncompress $1   ;;
      *.7z)        7z x $1         ;;
      "")      echo "usage: extract <Datei>";;
                *)           echo "Das Kompressionsformat von '$1' wird nicht unterstützt" ; return 1;;
         esac
     else
         echo "'$1' is no valid file"; return 2
     fi
}
# Ideen für die Zukunft:
# Anzeige für anstehende Updates
# Uhrzeit mit Farbindikator für niedrigen Batteriestatus (nur Laptops)
# Weitere Vorschläge an emanuel.regnath@tum.de
