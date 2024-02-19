#!/usr/bin/env bash
makoctl list | jq ".data.[].[] | select(.\"app-name\".data == \"$1\") | .id.data" | xargs -I '{}' makoctl dismiss -n '{}'
