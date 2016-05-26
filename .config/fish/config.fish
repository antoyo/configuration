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

function confcp
    cp ~/$argv[1] $argv[1]
end

function confdiff
    nvim -d $argv[1] ~/$argv[1]
end

# Aliases.
alias cdc "cd `xclip -o`"
alias cp "cp -i"
alias dcmake "cmake -DCMAKE_BUILD_TYPE=Debug .."
alias df "df -h"
alias fishconfig "nvim ~/.config/fish/config.fish"
alias genpass "xkcdpass -c 10 -n 4 -w ~/Documents/liste_francais.txt"
alias i3config "nvim ~/.i3/config"
alias ls "ls --color=auto -N"
alias mcabber "mcabber -f (mcabber_config_file|psub)"
alias mkdir "mkdir -p"
alias mount "udisksctl mount -b"
alias mount_cd "udisksctl mount -b /dev/sr0"
alias mv "mv -i"
alias nvimconfig "nvim ~/.config/nvim/init.vim"
alias rm "rm -i"
alias tarin "ssh boua1737@tarin.dinf.usherbrooke.ca"
alias trc "transmission-remote-cli"
alias unmount "udisksctl unmount -b"
alias unmount_cd "udisksctl unmount -b /dev/sr0"
alias urlsnews "nvim ~/.config/newsbeuter/urls"

function __fish_default_command_not_found_handler --on-event fish_command_not_found
  functions --erase __fish_command_not_found_setup
  echo "fish: Unknown command '$argv'"
end
