# History.
export HISTCONTROL=ignoreboth:erasedups

# Colors.
PS1="\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]"

# Aliases.
alias cdc="cd `xclip -o`"
alias cp="cp -i"
alias df="df -h"
alias ls="ls --color=auto"
alias lst="ls -ltur"
alias mcabber="mcabber -f <(cat ~/.mcabber/mcabberrc; printf 'set password = '; pass chat/dukgo)"
alias mkdir="mkdir -p"
alias mount="sudo mount -o uid=1000"
alias mv="mv -i"
alias omake="omake -w"
alias rm="rm -i"
alias trc="transmission-daemon && transmission-remote-cli"

# Nix Aliases.
alias install="sudo nix-env -iA"
alias search="sudo nix-env -qaP | grep"
alias upgrade="sudo nix-env --upgrade"
alias update="sudo nix-channel --update"
alias uu="update && upgrade"

# Environment variables.
export BROWSER="dwb"
export EDITOR="vim"
export GCC_COLORS=auto

# Nix.
source /etc/profile.d/nix.sh
