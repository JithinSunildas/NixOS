#!/bin/sh
windows=$(niri msg -j windows)
selected=$(echo "$windows" | jq -r '.[] | "\(.title) ( \(.app_id) )"' | fuzzel -d --index)

if [ -n "$selected" ]; then
    id=$(echo "$windows" | jq -r ".[$selected].id")
    niri msg action focus-window --id "$id"
fi
