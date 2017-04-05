

# colors
# =====================================================
set fish_color_command green   # color of correct command
set fish_color_cwd -o green
set fish_color_param cyan      # color of file name parameters



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
alias ...='cd ../..'
alias ....='cd ../../..'
alias ff='find . | grep -i'    # find file
alias fif='grep -InH -r'       # find in file
