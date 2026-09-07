#!/bin/bash


if lsusb | grep -i "DisplayLink"; then
    if [ "$1" == "open" ]; then
        hyprctl keyword monitor "eDP-1,1920x1080,0x0,1"
    else
        hyprctl keyword monitor "eDP-1,disable"
    fi
fi