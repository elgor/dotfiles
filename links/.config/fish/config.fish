

# add path
set PATH ~/.local/bin/ $PATH

# personal
# set -x CDPATH ~ ~/Dropbox/TUM/Promotion ~/nextCloud


# colors
# =====================================================
set fish_color_command green   # color of correct command
set fish_color_cwd -o green
set fish_color_param cyan      # color of file name parameters


# Settings
set fish_prompt_pwd_dir_length 3


# greeting
# =====================================================
function fish_greeting
set -l myuptime (uptime | sed "s/.*up \+\([^,]*\), .*/\1/")
set -l mydate (date "+%a  %x - %R")
set -l myhostname (hostname)
#set -l memfree (date "+%a  %x - %R")

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
\033[s│Date:   $mydate \033[u\033[42C│
\033[s│User:   $USER@$myhostname \033[u\033[42C│
\033[s│Uptime: $myuptime \033[u\033[42C│
└─────────────────────────────────────────┘
"
end



# function _short_path
#   set -l wdir string replace $HOME "~" (pwd)    #/home/user durch ~ ersetzen

#   set -l len string length $wdir
#   set -l maxlen math "$COLUMNS-18"
  
#   #check write permission
#   if [ -w "(pwd)" ]
#   	set -l cwdir=$cwdirw
#   else
#   	set -l cwdir=$cwdiruw
#   end

#   # if it fits
#   if [[ ${#wdir} -le $maxlen ]]
#     echo $wdir; return
#   end

#   # finds all the '/' in the path and stores their positions
#   set -l pos
#   set -l slashes=0
#   pos=() 

#   for i in ( seq len )
#     if [[ "${wdir:$i:1}" == / ]]
#       pos=(${pos[@]} $i)
#       let slashes++        
#     end
#   end

#   # calculate max displayed chars for each level
#   lastdir="/${wdir##*/}"
#   lastdirlen=${#lastdir}
#   eachlen=$(( (${maxlen}-$lastdirlen-1) / ($slashes-1) -1))  # length including /
#   #echo "${maxlen}, $slashes, $lastdirlen, $eachlen, "
  
#   if [[ $eachlen -le 1 ]]
#     eachlen=2
#     restlen=$(( (${maxlen}-2) - (${eachlen}+1)*($slashes-1) ))
#     if [[ $restlen -le 2 ]]
#     	restlen=2
#     end
#     lastdir="${lastdir:0:$restlen}…"
#   end

#   newpwd="${wdir:0:${pos[INDEX_START]}}"
#   for i in ( seq slashes-1 )
#     local folderlen=$((${pos[i+1]}-${pos[i]}))
#     if [[ ${folderlen} -gt $((${eachlen}+1)) ]]; then
#       newpwd+="${wdir:${pos[i]}:$eachlen}…"
#     else
#       newpwd+="${wdir:${pos[i]}:$folderlen}"
#     end
#   end
#   newpwd+="${lastdir}"

#   echo $newpwd
# end




# prompt
# =====================================================
function fish_prompt
	set -l res $status
	echo ''

	# check status
	if test $res -ne 0
		set_color red
	    echo "ERROR $res"
	    set_color normal
	end

	# check user
    switch $USER
    case root
	    if not set -q __fish_prompt_cwd
	        if set -q fish_color_cwd_root
	            set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
	        else
	            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
	        end
	    end
	end

	# git branch
	set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')
	if [ $git_branch ]
		set git_branch "$git_branch "
	end


	# display prompt 
	set_color cyan
    echo -n "┌─╸"(date +%H:%M)"╺─◆─┤ "
    # display pwd with home ~
    set -l tmppwd (echo $PWD | sed "s!$HOME!~!")
    set -l mypwd

    # short path
  	# if test (string length $tmppwd) -gt (math "$COLUMNS-18")
    	# too long, use the shortened version of dir instead
    #	set tmppwd (prompt_pwd)
  	#end

  	# color path
    if test -w $PWD
		set_color -o green 
		set mypwd (echo $tmppwd | sed "s!/!\x1b[1;33m/\x1b[1;32m!g")
	else
		set_color cyan
		set mypwd (echo $tmppwd | sed "s!/!\x1b[1;33m/\x1b[0;36m!g")
	end

    echo -n $mypwd
    set_color normal; set_color cyan
    echo -n " ├─■"\n"└─┤"(id -u -n)
    set_color -o yellow
    echo -n "§ "
    set_color normal; set_color cyan
    echo -n "$git_branch"
    set_color normal
end


# handy tools
# ---------------------------------------------------------------------
alias ...='cd ../..'
alias ....='cd ../../..'
alias ff='find . | grep -i'    # find file
alias fif='grep -InH -r'       # find in file

# network helpers
function myip
  echo "LAN: (ip route get 8.8.8.8 | awk '{print $NF; exit}')"
  # $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
  echo "WAN: (dig +short myip.opendns.com @resolver1.opendns.com)"
end

# function ipscan
#   local theip=(ip route get 8.8.8.8 | awk '{print $NF; exit}')
#   local ipbase="${theip%.*}."
#   #echo $(seq 254) | xargs -P255 -I% -d" " ping -W 2 -c 1 ${ipbase}% | grep -E "[0-1].*?:"
#   for i in (seq 254)
#   	(sleep 0.02; ping $ipbase$i -c 1 -W 2 | grep -E "[0-1].*?:" &) 
#   	sleep 1
#   end
# end

