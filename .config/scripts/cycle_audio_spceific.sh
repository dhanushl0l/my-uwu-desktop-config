#!/bin/bash

# Define allowed sinks
allowed_sinks=("alsa_output.usb-TTGK_Technology_Co._Ltd_Audiocular_D07-00.analog-stereo" "alsa_output.pci-0000_01_00.1.pro-output-7")

# Get the currently set default sink
current_sink=$(pactl get-default-sink)

# Filter sinks to only include allowed ones
sinks=()
for sink in "${allowed_sinks[@]}"; do
    if pactl list sinks short | grep -q "$sink"; then
        sinks+=("$sink")
    fi
done

# Find the current sink's position in the list
current_index=-1
for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current_sink" ]]; then
        current_index=$i
        break
    fi
done

# If current sink isn't found, exit the script
if [ $current_index -eq -1 ]; then
    echo "Current sink not found in allowed list."
    exit 1
fi

# Calculate the next sink index (wrap around if at the end)
next_index=$(( (current_index + 1) % ${#sinks[@]} ))

# Set the next sink as the default
pactl set-default-sink "${sinks[$next_index]}"

# Move all current audio streams to the new default sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "${sinks[$next_index]}"
done

# Get the human-readable name of the new sink
sink_description=$(pactl list sinks | grep -A 10 "Name: ${sinks[$next_index]}" | grep "Description:" | cut -d ' ' -f2-)

# Send a notification
notify-send -h string:x-dunst-stack-tag:audio-switch -u low -i audio-speakers "Audio Output Switched 🎵" "$sink_description"

echo "Switched to sink: ${sinks[$next_index]}"
