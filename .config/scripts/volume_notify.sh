#!/bin/bash

# Get the current volume
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '/Volume:/ {gsub(/[% ]/, "", $2); print $2}')

# Send a notification with a volume progress bar and a modern icon
notify-send -h string:x-dunst-stack-tag:volume-notification \
            -h int:value:$volume \
            -u low \
            -i audio-volume-high \
            "Volume Level" "$volume%"
