#!/usr/bin/env sh
active_port=$(pacmd list sinks | sed -n "/Aktív port:/p")
if echo "$active_port" | grep -q speaker; then
    `pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-headphones`
else
    `pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-speaker`
fi
