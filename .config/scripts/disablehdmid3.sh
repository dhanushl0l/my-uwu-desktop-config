#!/bin/bash

MONITOR="HDMI-A-3"

STATUS=$(hyprctl monitors | awk '
  /Monitor '"$MONITOR"'/ {flag=1; next}
  /^Monitor/ {flag=0}
  flag && /dpmsStatus/ {
    print $2
  }
')

echo "Current dpmsStatus of $MONITOR is: $STATUS"

if ! [ "$STATUS" = "1" ]; then
    echo "Turning $MONITOR ON"
    hyprctl dispatch dpms on "$MONITOR"
else
    echo "Turning $MONITOR OFF"
    hyprctl dispatch dpms off "$MONITOR"
fi

