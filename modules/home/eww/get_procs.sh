#!/usr/bin/env sh

ps -eo comm,%cpu --sort=-%cpu | head -n 6 | awk '{printf "%-15s %s%%\n", $1, $2}'
