#!/bin/zsh
kanata -c $HOME/.kanata.kbd &
if ! pgrep -x kime > /dev/null; then
kime &
fi
pipewire &
pipewire-pulse &
wireplumber &
xset -dpms &
xset s off &
setterm -powerdown 0 &
exec leftwm
