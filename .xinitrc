xsetroot -cursor_name left_ptr
unclutter &
xrdb -merge .Xresources
xrandr --output DVI-0 --mode 1280x720
feh --bg-scale ~/Images/image.png
xautolock -locker lock &
exec i3
