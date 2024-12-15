#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu

# Modified by Anhsirk0 for anhsirk0/rofi-config

# Current Theme
dir="$HOME/.config/rofi/powermenu/"
#time and date
TIME=$(date +"%I:%M%p")
DATE=$(date +"%d/%m/%y")

# CMDs
uptime=$(uptime -p | sed -e 's/up //g' -e 's/,//g' -e 's/\([0-9]*\) days/\1d/g' -e 's/\([0-9]*\) hours/\1h/g' -e 's/\([0-9]*\) minutes/\1m/g' -e 's/ //g')
host=`hostname`

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''


# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime Time: $TIME Date: $DATE" \
		-theme ${dir}/config.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/confirm/config.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
    if [[ $1 == '--lock' ]]; then
        hyprlock
        return
    fi

    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        case $1 in
            '--shutdown')
                systemctl poweroff
                ;;
            '--reboot')
                systemctl reboot
                ;;
            '--suspend')
                systemctl suspend
                ;;
            '--logout')
                hyprctl dispatch exit
                ;;
            *)
                echo "Invalid option: $1"
                exit 1
                ;;
        esac
    else
        exit 0
    fi
}


# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		run_cmd --lock
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
