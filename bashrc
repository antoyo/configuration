# Colors.
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# Alias
alias addon-sdk="cd /opt/addon-sdk && source bin/activate; cd -"
alias cp='cp -i'
alias df='df -h'
alias lo="ledit ocaml"
alias ls='ls --color=auto'
alias lst="ls -ltur"
alias mcabber="mcabber -f <(cat ~/.mcabber/mcabberrc; printf 'set password = '; pass chat)"
alias mkdir='mkdir -p'
alias mv='mv -i'
alias ob="ocamlbuild -use-ocamlfind"
alias rm='rm -i'

# Environment variables.
export EDITOR='vim'
export GCC_COLORS=auto
