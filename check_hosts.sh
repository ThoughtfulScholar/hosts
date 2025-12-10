#!/bin/bash


cat /etc/hosts | while read ip name rest; do

    [[ -z "$ip" ]] && continue
    [[ "$ip" =~ ^# ]] && continue

    [[ -z "$name" ]] && continue

    resolved=$(nslookup "$name" 2>/dev/null | awk '/Address: / { print $2; exit>


    if [[ "$resolved" != "$ip" ]]; then
        echo "Bogus IP for $name in /etc/hosts!"
    else
        echo "OK: $name"
    fi

done
