#!/bin/bash
outp=$(setxkbmap -query | grep 'variant' | awk -F" " '{ print $2 }')

case $outp in
"bone")
    layout="'de(neo)'"
    var="neo"
    ;;
"neo")
    layout="'de'"
    var="nodeadkeys"
    ;;
*)
    layout="'de(bone)'"
    var="bone"
esac

swaymsg input 1:1:AT_Translated_Set_2_keyboard xkb_layout $layout
setxkbmap -variant $var
notify-send "Keyboard layout switched to: " $layout
