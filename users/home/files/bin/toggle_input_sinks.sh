#!/usr/bin/env sh
IFS=$'\n' values=($(pactl list sink-inputs | grep -oP '\K[0-9]+(?=. nyelő)'))
for i in ${!values[@]}; do
    `pactl set-sink-input-mute ${values[i]} toggle`
done
