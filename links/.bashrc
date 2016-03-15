# ==========================================================================================
# Eingabeleiste v1.0 von Emanuel Regnath        Stand 29.01.2011
# 
# Funktionen der Eingabeleiste:
# - Uhrzeit
# - Benutzername mit Farbindikator für Rootuser
# - Verzeichnispfad mit Farbindikator für Schreibrechte und automatischer Skalierung
# - OPTIONAL: Fehlercode statt Verzeichnispfad bei fehlgeschlagenem Befehl
# ==========================================================================================

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# |              E I N S T E L L U N G E N                   |
# ============================================================


# Lokale setzen
export LANG=de_DE.UTF-8
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
PATH=$PATH:/home/emu/Software/avrada/bin:/home/emu/Software/gnat-470/bin
PATH=$PATH:/home/emu/.local/bin
PATH=/opt/spark2014/bin:$PATH
export PATH

# Falls keine interaktive Shell(zb Script), dann .bashrc beenden
[ -z "$PS1" ] && return


#check TTY
TTY_PATH=$(tty)
TTY_PATH=${TTY_PATH:5}

# Fensterüberschrift setzen aber nur wenn das Terminal nicht die Systemconsole ist
[ "$TERM" = "linux" ] && TITLEBAR="" || TITLEBAR="\[\033]0;\u@\h on $TTY_PATH\007\]"



# check shell
if test -n "$BASH_VERSION"; then
  echo $BASH_VERSION
  export SHELL=$(which bash)
  # set VI key bindings
  set -o vi
  isBash=true
  USER_SYMBOL="\u"
  HOST_SYMBOL="\h"
  TIME_SYMBOL="\t"
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
  TIME_SYMBOL="%*"
  UMARK="%(!.#.%%)" 
  TITLEBAR=""

zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="(CMD)"
  # () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}


fi





# check for git
# Problem: doppelte indirekte addressierung nicht möglich, vl mit hilfsvar und test?
# GIT_INFO='', da 
if [ -x "$(which git)" ]; then
  GIT_INFO="git_branch"
  GIT_BRANCH_SYMBOL='⑂'
  GIT_BRANCH_CHANGED_SYMBOL='+'
  GIT_NEED_PUSH_SYMBOL='⇡'
  GIT_NEED_PULL_SYMBOL='⇣'
  export GIT_INFO 
else
  export GIT_INFO=''
fi


if [ -x "$(which svn)" ]; then
  export SVN_INFO="svn_branch"
  SVN_BRANCH_SYMBOL='⚡'
else
  export SVN_INFO=''
fi



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
  shopt -s checkwinsize   # handle xterm resizing
  shopt -s cmdhist        # save multi-line commands as one line
  shopt -s dotglob        # allow tab-completion of '.' filenames
  shopt -s hostcomplete   # tab-complete words containing @ as hostnames
  shopt -s execfail # failed execs don't exit shell
  set -o notify           # show status of terminated programs immediately

  # Bash sudo completion
  complete -cf sudo
else
  setopt HIST_IGNORE_DUPS
  setopt autocd     # auto cd to dir
fi


# cd with ls
#function cd {
#    builtin cd "$@" && ls -AB --color=always --group-directories-first
#}#




# Aliase über Aliase...
# --------------------------------->
alias ..='cd ..'; alias ...='cd ../..'; alias ....='cd ../../..'
alias cd..='cd ..'

alias ls='dirinfo; ls -BC --color=always --group-directories-first'   #| more -f
alias sl='ls'

alias ll='ls -l'

# file manipulation
alias rm='rm -i'
#alias cp='cp -u'
alias mv='mv -i'



alias du='du -sh'     # disk usage is human
alias df='df -h'      # disk freespace is human

alias grep='grep --color=auto'

alias f='find . -maxdepth 1 | grep -i'    # f=find <Wort>
alias fa='find . | grep -i'     # fa=find all <Wort>


alias x='extract'       # x=eXtract <Datei>

#set LS_COLORS
#LS_COLORS = 'di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
[ -f "~/.dircolors" ] && eval "$(dircolors -b ~/.dircolors)" 
#export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.taz=01;31:*.zip=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;35:*.rpm=01;35:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.7z=01;31:*.rz=01;31:*.pdf=00;91:*.PDF=00;91:*.dps=00;91:*.jpg=00;35:*.JPG=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.svg=00;35:*.svgz=00;35:*.mng=00;35:*.pcx=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.m2v=00;35:*.mkv=00;35:*.webm=00;35:*.ogm=00;35:*.mp4=00;35:*.m4v=00;35:*.mp4v=00;35:*.vob=00;35:*.qt=00;35:*.nuv=00;35:*.wmv=00;35:*.asf=00;35:*.rm=00;35:*.rmvb=00;35:*.flc=00;35:*.avi=00;35:*.fli=00;35:*.flv=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.yuv=00;35:*.cgm=00;35:*.emf=00;35:*.axv=00;35:*.anx=00;35:*.ogv=00;35:*.ogx=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'


# Override lame default apps with useful 3rd-party ones if they exist
[ -x "$(which pinfo)" ] && alias info=`which pinfo`
[ -x "$(which htop)" ] && alias top=`which htop`
[ -x "$(which colormake)" ] && alias make=`which colormake`
[ -x "$(which colordiff)" ] && alias diff=`which colordiff`
[ -x "$(which colorgcc)" ] && alias gcc=`which colorgcc`
[ -x "$(which colorsvn)" ] && alias svn=`which colorsvn`


# Farben definieren
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


# Farbeinstellungen:
# --------------------------------->
cline="${cyan}" # Farbe der Verzierung
ctime="${CYAN}"
cgit="${GRAY}"
cnone="${white}"
cuser="${YELLOW}"
croot="${PURPLE}"
cwdirw="${GREEN}" # Farbe für Verzeichnis mit Schreibrechten
cwdiruw="${GRAY}" # Farbe für Verzeichnis ohne Schreibrechte


COLOR_COMMAND=${WHITE}
COLOR_BASHRC_DEFINED=${BLUE}
COLOR_NOT_INSTALLED=${GRAY}
COLOR_DEFAULT=${white}

# Falls root-login dann userfarbe ändern.
[ $UID -eq 0 ] && cuser=${croot}


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
# |                S T A R T A N Z E I G E                   |
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
\033[s│User:   $USER   \033[u\033[42C│
\033[s│Host:   $(hostname)   \033[u\033[42C│
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
  local -i maxlen=${COLUMNS}-24
  
  #check writing permission
  [ -w "$(pwd)" ] && cwdir=${cwdirw} || cwdir=${cwdiruw}
  
  # if it fits
  if [[ ${#wdir} -le $maxlen ]]; then
    echo $wdir
    return
  fi

  # finds all the '/' in the path and stores their positions
  local pos
  pos=()
  local slashes=0
  if $isBash; then INDEX_START=0; else INDEX_START=1; fi
  local -i i=$INDEX_START
  for ((i=$INDEX_START;i<len+$INDEX_START;i++))
  do
    if [[ "${wdir:$i:1}" == / ]]
    then
      pos=(${pos[@]} $i)
      let slashes++        
    fi
  done
  #pos=(${pos[@]} $len)

  # calculate max displayed chars
  #chars=$(( ($slashes-2)*4 + ($len-${pos[($slashes-2)]}) ))
  #echo $(($len-${pos[($slashes-1)]})) 
  #echo $chars

  newpwd="${wdir:0:${pos[INDEX_START]}}"
  for ((i=$INDEX_START;i<slashes-1+$INDEX_START;i++))
  do
    local folderlen=$((pos[i+1]-pos[i]))
    if [[ ${folderlen} -ge 6 ]]; then
      #newpwd+="${WHITE}/${white}"
      newpwd+="${wdir:${pos[i]}:4}…"
    else
      newpwd+="${wdir:${pos[i]}:$folderlen}"
    fi
  done
  newpwd+="${wdir:${pos[i]}}"
  
  # check if still too long
  if [[ ${#newpwd} -le $maxlen ]]; then
    echo $newpwd
    return
  else 
    newpwd="${wdir:0:${pos[$INDEX_START]}}"
    for ((i=$INDEX_START;i<slashes-1+$INDEX_START;i++))
    do
      newpwd+="/…"
    done
    newpwd+="${wdir:${pos[i]}}"
    
    
    # check if still too long
    if [[ ${#newpwd} > $maxlen ]]; then
      let carryover=24+${#wdir}-${COLUMNS}
      #newpwd="${wdir:0:3}……${wdir:((${carryover}+5))}"
      newpwd="...${wdir:((${carryover}+3))}"
    fi      
  fi

  echo $newpwd
}



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# |                 E I N G A B E T E X T                    |
# ============================================================

# Prompt-Funktion:
function custom_prompt_command()
{
  # Rückgabewert des letzen Befehls abfangen:
  retval=$?

  # append last command to history NOW (crash-safe)
  # history -a

  # War der letzte Befehl erfolgreich?
  # -------------------------------------------------------------------------->
  if [ $retval -eq 0 ]; then
 
    # Schreibrechte im Arbeitsverzeichnis? Farbe ändern
    [ -w "$(pwd)" ] && cwdir=${cwdirw} || cwdir=${cwdiruw}

    # $wdir zuschneiden damit es immer ins Fenster passt:
    wdir=$(_short_path)

  else
    # Verzeichnispfad durch Fehlercode ersetzen:
    wdir="ERROR ${retval}"; cwdir=${red}
  fi
  # <*************************************************************************



  ## Ladies and gentlemen, $PS1 ##
  #${TITLEBAR}\n
  PS1="$TITLEBAR
${cline}┌──╸${ctime}${TIME_SYMBOL}${cline}╺──◆──┤ ${cwdir}${wdir} ${cline}├─■
${cline}└─┤${cuser}${USER_SYMBOL}${HOST_INFO}${UMARK} ${white}"

  #Test
  # git befehl verursacht definitiv sprünge vom cursor
  PS1+="${cgit}$(${GIT_INFO})$(${SVN_INFO})${cnone}"
  PS2="${cline}└◆┤${white} "

}

# Befehl ausführen
if $isBash; then
  PROMPT_COMMAND=custom_prompt_command
else
  function precmd { 
  	RPROMPT=""
    print -Pn "\e]0;%n@%m\a"
    custom_prompt_command 
  }
  #function chpwd { 
  #}
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# |                 F U N K T I O N E N                      |
# ============================================================


# Information über ein Verzeichnis
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


# Runs configure make and make install with dumb error handling
function install_source {
    if [[ $# != 1 ]]; then
        echo "Using $PWD as source location."
    elif [[ $# == 2 ]]; then
        cd $2
    fi

    if [[ ! -x ./configure ]]; then
        echo "Could not find configure script in $PWD!"
        return 1
    fi

    ./configure
    if [[ $? != 0 ]]; then
        echo -e "\nA problem occured with the automated configuration.\n"
        return 1
    fi

    make
    if [[ $? != 0 ]]; then
        echo -e "\nA problem happened while making this program.\n"
        return 1
    fi

    make install
    if [[ $? != 0 ]]; then
        echo -e "\nA problem happened while installing the program.\n"
        return 1
    fi
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
         echo "'$1' ist keine gültige Datei"; return 2
     fi
}
# Ideen für die Zukunft:
# Anzeige für anstehende Updates
# Uhrzeit mit Farbindikator für niedrigen Batteriestatus (nur Laptops)
# Weiter Vorschläge an emanuel.regnath@tum.de
