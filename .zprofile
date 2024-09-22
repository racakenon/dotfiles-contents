#!/bin/sh
pipewire &
wireplumber &
dbus-run-session niri --session&
$HOME/.config/niri/swww-switch&
