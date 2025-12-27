#!/home/tikhaboom/.nix-profile/bin/bash

app="$SWAYNC_APP_NAME"
id=$(niri msg windows --json | jq -r \
    ".Ok | map(select(.app_id == \"$app\"))[0].id")
[ -n "$id" ] && niri msg action focus-window --id "$id"
