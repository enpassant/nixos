#!/usr/bin/env bash
~/bin/hide-app-noti.sh $1
read -rst 0.1
MENU=$(echo "$3" | sed 's/-/@-/g'  - | sed 's/\\n/\n/g' - | column -t -s '@')
notify-send -t 0 -a "$1" "$2" "$MENU"
