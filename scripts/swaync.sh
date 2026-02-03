#!/bin/sh
APP_ID=$1

# Get the internal Niri ID for the first window matching that app_id
WINDOW_ID=$(niri msg -j windows | jq -r ".[] | select(.app_id == \"$APP_ID\") | .id" | head -n 1)

if [ -n "$WINDOW_ID" ]; then
    niri msg action focus-window --id "$WINDOW_ID"
else
    # Optional: if the app isn't open, maybe launch it?
    $APP_ID &
fi
