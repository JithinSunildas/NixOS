#!/home/tikhaboom/.nix-profile/bin/bash

HELIX_CWD=$(readlink /proc/$PPID/cwd)

tmux split-window -h -p 30 -c $HELIX_CWD "yazi"
