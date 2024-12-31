#!/bin/bash

# Get the current volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '/Volume:/ {gsub(/[% ]/, "", $2); print $2}')

# Send a notification with a volume progress bar and a modern icon
dunstify -h string:x-dunst-stack-tag:volume-notification -u low -i audio-volume-high "Volume Level" "$volume%" -h int:value:$volume
