#!/usr/bin/env sh

# Gather metrics safely
MEM=$(free -h | awk 'NR==2{print "Mem:  " $3 " / " $2}')

CPU_TEMP=$(sensors 2>/dev/null | grep -i 'Core 0' | awk '{print $3}')
[ -z "$CPU_TEMP" ] && CPU_TEMP=$(sensors 2>/dev/null | grep -i 'temp1' | head -n1 | awk '{print $2}')
[ -z "$CPU_TEMP" ] && CPU_TEMP="N/A"

PROCS=$(ps -eo comm,%cpu --sort=-%cpu | head -n 6 | tail -n +2 | awk '{printf "%-15s %s%%\n", $1, $2}')

# Build the block using a multi-line literal string variable block
OUTPUT="=== SYSTEM ===
$MEM
Temp: $CPU_TEMP

=== TOP PROCESSES ===
$PROCS"

# Use printf to feed the text safely into jq without collapsing newlines
printf '%s' "$OUTPUT" | jq -R -s '{"text": .}'
