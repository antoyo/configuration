xsetroot -cursor_name left_ptr
unclutter &
xrdb -merge .Xresources
xrandr --output LVDS-1 --auto --output VGA-1 --auto --left-of LVDS-1 --primary
feh --bg-scale ~/Images/image.png
xautolock -locker lock &
exec i3
