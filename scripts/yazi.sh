#!/home/tikhaboom/.nix-profile/bin/bash

function yzf(){
  local TEMP=$(mktemp)
  yazi -- -selection-path=$TEMP
  cat $TEMP
}
