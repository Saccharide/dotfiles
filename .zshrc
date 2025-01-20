# Enable colors and change prompt:
autoload -U colors && colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
export PROMPT_COMMAND=__prompt_command      # Func to gen PS1 after CMDs

export color_prompt="yes"
function __prompt_command(){
        local EXIT="$?"
        if [ "$color_prompt" = yes ]; then
            # change terminal title to be the current directory
            PS1="\[\e]0;\w\a\]\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;31m\]$EXIT\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
        else
            PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
        fi

}
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Reverse search
bindkey -v
bindkey '^R' history-incremental-search-backward


#
#
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
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


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)     # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
alias v="vim "
alias g="cd ~/git"
alias ll='ls -halt'
alias dd='dd status=progress'
alias _='sudo '
alias p='python '
alias p3='python3 '
alias f='fg '
alias j='jobs '
alias du='du -ch --max-depth=1 .'
export VISUAL=vim
export EDITOR="$VISUAL"
#
#
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
    youtube-dl $1 -x --audio-format mp3 --audio-quality 0 
}
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
