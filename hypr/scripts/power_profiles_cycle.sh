#!/usr/bin/env bash
# Cycles through power-profiles-daemon profiles: performance -> balanced -> power-saver -> performance ...

profiles=("performance" "balanced" "power-saver")
current=$(powerprofilesctl get)

# find index of current profile
idx=0
for i in "${!profiles[@]}"; do
    if [[ "${profiles[$i]}" == "$current" ]]; then
        idx=$i
        break
    fi
done

next_idx=$(( (idx + 1) % ${#profiles[@]} ))
next_profile="${profiles[$next_idx]}"

powerprofilesctl set "$next_profile"

# optional: desktop notification (needs a notification daemon, e.g. mako/dunst)
notify-send -a "Power Profile" "Switched to: $next_profile" -t 1500