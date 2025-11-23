##################################################################################################
# '''
# // @Project      Cool Bashrc from Parrot OS
# // @Author       Saccharide
# '''
##################################################################################################


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:~/local/bin:~/.local/bin

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

# If this is an xterm set the title to user@host:dir


export color_prompt="yes"

# Replacing the error mark with error code retrun by the program 
export PROMPT_COMMAND=__prompt_command      # Func to gen PS1 after CMDs

export __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"

function __prompt_command(){
    prompt_color='\[\033[;94m\]'
    info_color='\[\033[1;31m\]'
    git_color='\[\033[;33m\]'
    prompt_symbol=㉿

    host_color='\[\033[01;31m\]'
    user_color='\[\033[01;96m\]'
    dir_color='\[\033[0;32m\]'
        local EXIT="$?"
                if [ "$color_prompt" = yes ]; then
                    if [ -z "${VIRTUAL_ENV}" ] ; then
                    # change terminal title to be the current directory
                    PS1="\[\e]0;\w\a\]\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;31m\]$EXIT\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]$(__git_ps1) $(date +%m/%d/%y\ %H:%M:%S)\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"

                    #PS1="\[\e]0;\w\a\]$prompt_color\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"$info_color[$EXIT$info_color]$prompt_color\342\224\200\")["$prompt_color'${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}'$user_color'\u'$prompt_color''$prompt_symbol''$host_color'\h'$prompt_color']-['$dir_color'\w'$prompt_color']'$git_color"$(__git_ps1) $prompt_color$(date +%m/%d/%y\ %H:%M:%S)"'\n'$prompt_color'└─'$prompt_color'\$\[\033[0m\] '
 
                    else

                        PS1="\[\e]0;\w\a\]\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;31m\]$EXIT\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]$(__git_ps1) ($(basename $VIRTUAL_ENV)) $(date +%m/%d/%y\ %H:%M:%S)\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
                    fi
                        #PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;31m\]$EXIT\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
                        #PROMPT_COMMAND='echo -ne "\033]0;\w\007"'
                else
                        PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
                fi
}


# Original color setting
# case "$TERM" in
# xterm*|rxvt*)
#     EXIT=$?
#     echo $EXIT
#     PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\$EXIT\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -halt'
alias la='ls -la'
alias l='ls -halt'
alias dd='dd status=progress'
alias _='sudo '
alias old="cd $OLDPWD"
alias open='xdg-open'
alias v='vim'
alias g="cd $HOME/git"
export G="$HOME/git"
alias m="cd $HOME/Music"
export M="$HOME/Music"
alias p='python'
alias p3='python3'
alias sudo='sudo '
alias f='fg '
alias d='cd $HOME/Desktop '
alias j='jobs '
alias hexdump='hexdump -C '
alias du='du -ch --max-depth=1 .'
export HISTTIMEFORMAT='%F %T '
export VISUAL=vim
export EDITOR="$VISUAL"
export CLICOLOR=1
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# check if local bin folder exist
# $HOME/bin
# prepend it to $PATH if so
if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

export TERM="xterm-256color"

# Added a function to find certain file within the current directory
function findf(){
    if [[ -z $1 ]]; then
        echo "name cannot be empty."
        return
    fi
    find $(pwd) -iname "*$1*"
}
function gen(){
    if [[ -z $1 ]]; then
        echo "writeup file name cannot be empty."
        return
    fi
    echo -e "# $1\n## Author: saccharide\n\n## Approach\n\n## Exploit\n" > "$1.md"
}
function pgrep(){
    if [[ -z $1 ]]; then
        echo "Search string cannot be empty."
        return
    fi
    ls | xargs -P 0 -I folder grep --color=always -riHIns "$1" folder 
    }

    function line(){
        if [[ -z $1 || -z $2 ]]; then
            echo "Usage: line LINE_NUMBER FILE_NAME"
            echo "Ex: line 4 file.txt"
            return

        elif [[ $3 ]]; then
            awk "($1-5)<NR && NR<($1+5){print}" $2
            return

        else
            awk "($1-3)<NR && NR<($1+3){print}" $2
            return
        fi
    }

    function sshlab(){
        if [[ -f 'creds' ]]; then
            pass=`tail -n 1 creds`
            server=`head -n 1 creds`
            sed -i "s/ssh.*$/$server/g" ~/.login
            sed -i "s/send.*$/send $pass/g" ~/.login
            sed -i 's/send.*$/&\\n;/g' ~/.login
            cat ~/.login
            ~/.login
            return

        else
            echo "'creds' file does not exisit. Quitting..."
            return
        fi
    }

    set -o vi

    LS_COLORS=$LS_COLORS':di=36;01'
    LS_COLORS=$LS_COLORS':tw=36;01'
    LS_COLORS=$LS_COLORS':ow=36;01'
    export LS_COLORS
function a(){
    if [[ -f "x.py" ]]; then
        echo "x.py already exist!"
        return
    fi
    echo -e "from pwn import *\nimport angr\ncontext.update(arch='i386', os='linux')\n\np = angr.Project('./target')\n" > x.py
 
    echo 'accepted' >> x.py
}

function download(){
    if [[ -z $1 ]]; then
        echo "download link cannot be empty."
        return
    fi
    yt-dlp $1 -x --audio-format mp3 --audio-quality 0 
}

# fzf install from git release page, also install fd and batcat and eza
alias fd="fdfind "
alias bat="batcat "
alias fz="fzf"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
# ------------FZF--------------
# Set up fzf key bindings and fuzzy completion
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'batcat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"


# Script to list recent files and open vim using fzf
# set to an alias nlof in .zshrc

function vv() {
    # Define the vimtmp directory and file path
    local vimtmp_dir=~/.vimtmp
    
    # Ensure the directory exists
    if [[ ! -d "$vimtmp_dir" ]]; then
        echo "The directory $vimtmp_dir does not exist."
        return 1
    fi

    # List files in the vimtmp directory
    local oldfiles=($(find "$vimtmp_dir" -type f))

    # Debugging: Show what files were found
    echo "Found the following files in $vimtmp_dir:"
    for file in "${oldfiles[@]}"; do
        echo "$file"
    done

    # Filter invalid paths or files not found
    local valid_files=()
    for file in "${oldfiles[@]}"; do
        # Check if the file exists (not just its path)
        if [[ -f "$file" ]]; then
            valid_files+=("$file")
        fi
    done

    # If no valid files were found
    if [[ ${#valid_files[@]} -eq 0 ]]; then
        echo "No recent files found."
        return 1
    fi

    # Use fzf to select from valid files
    local files=($(printf "%s\n" "${valid_files[@]}" | \
        grep -v '\[.*' | \
        fzf --multi \
        --preview 'bat -n --color=always --line-range=:500 {} 2>/dev/null || echo "Error previewing file"' \
        --height=70% \
        --layout=default))

    # Open selected files in vim
    if [[ ${#files[@]} -gt 0 ]]; then
        # Resolve real paths for each selected file
        local real_files=()
        for file in "${files[@]}"; do
            file="${file/#$HOME\/.vimtmp\//}"
            file="${file//%/\/}"
            real_files+=("$file")
        done
        echo "Opening files: ${real_files[@]}"
        vim "${real_files[@]}"
    else
        echo "No files selected."
    fi
}

