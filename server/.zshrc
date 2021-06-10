# TODO add csh-like history navigation
# TODO add .cshrc time variable

# aliases

alias rr="clear && exec zsh"
alias lj="jobs -l"
alias kj="kill -9 %1"
alias ls="ls -hFG"
alias la="ls -hFGA"
alias ll="ls -hlFGA"
alias vc="code-oss"
alias p4="curl https://ipv4.wtfismyip.com/text"
alias p6="curl https://wtfismyip.com/text"
alias sndstat="cat /dev/sndstat"
alias updatedb="/usr/libexec/locate.updatedb"

# editor

export EDITOR=nano
export VISUAL=$EDITOR

export PAGER=less

# history

export HISTFILE=~/.histfile
export HISTSIZE=1000000000 # make it  i n f i n i t e
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# emacs-like navigation
bindkey -e

# prompt (we want to cheat by removing the %G in %{➤%G%} to align the right side better)
# export PROMPT=$'%{\e[38;5;124m%}%(?.%{✔%G%}.%{✖%G%} %?) %{\e[38;5;130m%}%m %{\e[38;5;136m%}%1~ %{\e[38;5;142m%}%{➤%}%{\e[0m%}  '
# export RPROMPT=$'%{\e[38;5;148m%}%D{%H:%M}%{\e[0m%}'

if [[ $UID == 0 || $EUID == 0 ]]; then
	export PROMPT=$'%{\e[33;3m%}%(?.%{✔%G%}.%{✖%G%} %?) %{\e[33;1m%}root %{\e[31m%}%1~ %{\e[31m%}%{➤%}%{\e[0m%}  '
	export RPROMPT=$'%{\e[35;3m%}%D{%H:%M}%{\e[0m%}'
else
	export PROMPT=$'%{\e[35;3m%}%(?.%{✔%G%}.%{✖%G%} %?) %{\e[34m%}%m %{\e[36m%}%1~ %{\e[36m%}%{➤%}%{\e[0m%}  '
	export RPROMPT=$'%{\e[33;3m%}%D{%H:%M}%{\e[0m%}'
fi

# keybindings

WORDCHARS='' # less infuriating than default delimiters

bindkey "^?" backward-delete-word
bindkey "^W" backward-delete-word # in case previous hack doesn't work

bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# language

export LANG="en_GB.UTF-8"

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/obiwac/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# extensions

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_HIGHLIGHT_STYLES[path]=fg=yellow
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=yellow

if [[ $UID == 0 || $EUID == 0 ]]; then
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=red,underline # stuff like exec
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=red
	ZSH_HIGHLIGHT_STYLES[command]=fg=red
	ZSH_HIGHLIGHT_STYLES[builtin]=fg=red
	ZSH_HIGHLIGHT_STYLES[alias]=fg=red
	ZSH_HIGHLIGHT_STYLES[function]=fg=red
fi

bindkey '^ ' autosuggest-accept

# welcome prompt

echo "aquaBSD 2021 (DEV BUILD)"
echo "ZSH version `zsh --version | awk '{print $2}'`"
echo

if [[ $UID == 0 || $EUID == 0 ]]; then
	echo -e "\e[31;1mWARNING: \e[0m\e[31mYou are running as a root user. Tread carefully."
	echo
fi
