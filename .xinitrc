xsetroot -cursor_name left_ptr
unclutter &
xrdb -merge .Xresources

# Screen configuration
xrandr --output VGA-0 --mode 1440x900 --rate 75 --left-of DVI-0 --primary --output DVI-I-1 --mode 1440x900 --rate 75

feh --bg-scale ~/Images/image.png
xautolock -locker lock &
exec i3
