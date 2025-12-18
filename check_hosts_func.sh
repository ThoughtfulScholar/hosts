#!/bin/bash

DNS_SERVER=8.8.8.8

check_host() {
    local host=$1
    local expected_ip=$2
    local dns_server=$3

    real_ip=$(nslookup "$host" "$dns_server" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n1)

    if [[ "$real_ip" != "$expected_ip" ]]; then
        echo "Bogus IP for $host in /etc/hosts! Expected $expected_ip, got $real_ip"
    fi
}

cat /etc/hosts | while read ip host; do
    [[ -z "$ip" || "$ip" == \#* ]] && continue
    check_host "$host" "$ip" "$DNS_SERVER"
done
