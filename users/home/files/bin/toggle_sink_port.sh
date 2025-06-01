#!/usr/bin/env sh
active_port=$(pactl list sinks | sed -n "/Aktív port:/p")
if echo "$active_port" | grep -q headphones; then
    pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-speaker
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 pro-audio
else
    pactl set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-stereo+input:analog-stereo
    pactl set-sink-port alsa_output.pci-0000_00_1b.0.analog-stereo analog-output-headphones
fi
