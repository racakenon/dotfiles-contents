#!/bin/sh
pipewire &
pipewire-pulse &
wireplumber &
niri --session&
$HOME/.config/niri/swww-switch&
