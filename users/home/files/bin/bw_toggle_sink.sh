#!/usr/bin/env sh
headphone_sink="alsa_output.pci-0000_04_00.6.analog-stereo"
speaker_sink="bluez_output.FF_CC_B6_08_FC_33.1"
default_sink=$(pactl get-default-sink)

if [ "$default_sink" == "$headphone_sink" ] ; then
    pactl set-default-sink $speaker_sink
else
    pactl set-default-sink $headphone_sink
fi
