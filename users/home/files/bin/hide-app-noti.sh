#!/usr/bin/env bash
makoctl list | grep "$1" -B 1 | grep Notification | sed -e 's/Notification \([0-9]\+\).\+/\1/' | xargs -I '{}' makoctl dismiss -n '{}'
