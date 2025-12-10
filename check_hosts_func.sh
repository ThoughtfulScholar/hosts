#!/bin/bash

check_ip() {
    local name="$1"
    local ip="$2"
    local dns_server="$3"

    resolved=$(nslookup "$name" "$dns_server" 2>/dev/null | awk '/Address: / { print $2; exit }')

    if [[ "$resolved" != "$ip" ]]; then
        echo "Bogus IP for $name!"
    else
        echo "OK: $name"
    fi
}
