#!/usr/bin/env bash

theme="$HOME/.config/rofi/powermenu/powermenu.rasi"

hibernate=''
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

rofi_cmd() {
	rofi -dmenu \
		-p "$USER@$(hostname)" \
		-mesg " Uptime: $(uptime | awk '{print substr($3, 1, length($3)-1)}')" \
		-theme ${theme}
}

confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${theme}
}

confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
	[[ "$(confirm_exit)" == "$yes" ]] && systemctl poweroff
	;;
$reboot)
	[[ "$(confirm_exit)" == "$yes" ]] && systemctl reboot
	;;
$hibernate)
	[[ "$(confirm_exit)" == "$yes" ]] && systemctl hibernate
	;;
$lock)
	hyprlock
	;;
$suspend)
	systemctl suspend
	;;
$logout)
	hyprctl dispatch exit
	;;
esac
