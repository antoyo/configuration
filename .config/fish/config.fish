function fish_prompt
    set last_status $status
    set_color $fish_color_cwd
    printf '%s ' (prompt_pwd)
    set_color normal
end

# MCabber function.
function mcabber_config_file
    cat ~/.mcabber/mcabberrc
    printf 'set password = '
    pass chat/dukgo
end

function mcp
    scp $argv[1] mediac@ghislain-desktop.local:~/Vidéos
end

function mkc
    mkdir $argv[1]; cd $argv[1]
end

# Aliases.
alias cdc "cd `xclip -o`"
alias cp "cp -i"
alias df "df -h"
alias ls "ls --color=auto"
alias mcabber "mcabber -f (mcabber_config_file|psub)"
alias mkdir "mkdir -p"
alias mount "sudo mount -o uid=1000"
alias mount_cd "sudo mount -t iso9660 -o ro /dev/cdrom /mnt/cdrom"
alias mv "mv -i"
alias rm "rm -i"
alias tarin "ssh boua1737@tarin.dinf.usherbrooke.ca"
alias trc "transmission-daemon; transmission-remote-cli"
