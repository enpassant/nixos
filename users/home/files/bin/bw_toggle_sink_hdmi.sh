#!/usr/bin/env sh
headphone_sink="alsa_output.pci-0000_04_00.6.analog-stereo"
speaker_sink="alsa_output.pci-0000_04_00.1.hdmi-stereo"
default_sink=$(pactl get-default-sink)

if [ "$default_sink" == "$headphone_sink" ] ; then
    pactl set-default-sink $speaker_sink
else
    pactl set-default-sink $headphone_sink
fi
