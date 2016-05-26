xsetroot -cursor_name left_ptr
unclutter -root &
xrdb -merge .Xresources

# Screen configuration
xrandr --output VGA-0 --mode 1440x900 --rate 75 --right-of DVI-0 --primary --output DVI-0 --mode 1440x900 --rate 75

feh --bg-scale ~/Images/image.png
exec i3
