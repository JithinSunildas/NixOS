#!/home/tikhaboom/.nix-profile/bin/bash

killall -q swaync
while pgrep -x swaync >/dev/null; do sleep 0.1; done
swaync &

echo "SwayNC started successfully!"
