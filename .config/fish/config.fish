# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
 
function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal
    printf '%s ' (__fish_git_prompt)
    set_color normal
end

# MCabber function.
function mcabber_config_file
    cat ~/.mcabber/mcabberrc
    printf 'set password = '
    pass chat/dukgo
end

# Aliases.
alias cdc "cd `xclip -o`"
alias cp "cp -i"
alias df "df -h"
alias ls "ls --color=auto"
alias lst "ls -ltur"
alias mcabber "mcabber -f (mcabber_config_file|psub)"
alias mediacenter "sudo mount -t nfs hp-g62-laptop.local:/Downloads /mnt/mediacenter/"
alias mkdir "mkdir -p"
alias mount "sudo mount -o uid=1000"
alias mv "mv -i"
alias omake "omake -w"
alias rm "rm -i"
alias tarin "ssh boua1737@tarin.dinf.usherbrooke.ca"
alias trc "transmission-daemon; transmission-remote-cli"

# OPAM configuration
. /home/bouanto/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true
