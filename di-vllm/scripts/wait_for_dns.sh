#!/bin/bash



DOMAINS=(
    "$URL"
)

for DOMAIN in "${DOMAINS[@]}"; do
    while true; do
        IP=$(getent ahosts $DOMAIN | awk '{print $1; exit}')
        if [ -n "$IP" ]; then
            if [ "$IP" == "$HOST_IP" ]; then
                echo "Domain $DOMAIN resolved to correct IP: $IP"
                break
            else
                echo "Domain $DOMAIN resolved to IP: $IP, but does not match VM IP: $VM_IP"
            fi
        else
            echo "Waiting for DNS resolution of $DOMAIN..."
        fi
        sleep 10
    done
done

echo "All domains resolved to the correct IP. Proceeding..."