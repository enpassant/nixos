#!/usr/bin/env sh
mapfile -t values < <(pacmd list-sink-inputs | grep -oP '(index: \K[0-9]+)')
for i in ${!values[@]}; do
    `pactl set-sink-input-mute ${values[i]} toggle`
done
