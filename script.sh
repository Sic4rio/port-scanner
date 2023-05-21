#!/bin/bash
# Variables
empty=""

# Color codes
GREEN="\033[0;32m"
NC="\033[0m" # No color

# Arguments for the script
while [ "$1" != "" ]; do
    case "$1" in
        -i | --ip )     ip="$2";   shift;;
        -p | --ports )  ports="$2";   shift;;
    esac
    shift
done

# Checking if -i is empty
if [[ $ip == $empty ]]; then
    echo "Please specify an IP address with -i"
    exit
fi

# Checking if -p is empty
if [[ $ports == $empty ]]; then
    echo "Please specify the max port range -p"
    exit
fi

# Scans ports, dumps closed ports, and displays open ports
for i in $(seq 1 $ports); do
    if ( echo > /dev/tcp/$ip/$i ) > /dev/null 2>&1; then
        echo -e "${ip}:${i} ${GREEN}is open${NC}"
    fi
done
