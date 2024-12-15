#!/bin/bash

# Get a list of all sink names (not indices) from the pactl list
sinks=($(pactl list short sinks | awk '{print $2}'))

# Get the currently set default sink
current_sink=$(pactl get-default-sink)

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
    echo "Current sink not found."
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

echo "Switched to sink: ${sinks[$next_index]}"
