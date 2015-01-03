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

# Environment variables.
export BROWSER="dwb"
export EDITOR="vim"
export GCC_COLORS=auto
export PATH="~/.cabal/bin:~/Ordinateur/Programmation/Haskell/CabalSandboxes/Yesod/bin:~/Ordinateur/Programmation/Haskell/CabalSandboxes/Snap/bin:$PATH"
