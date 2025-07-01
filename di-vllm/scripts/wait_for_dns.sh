#!/bin/bash

VM_IP=$(hostname -I | awk '{print $1}')

source .env

DOMAINS=(
    "$TRAEFIK_DASHBOARD_URL"
    "$VLLM_URL"
    "$GRAFANA_URL"
)

for DOMAIN in "${DOMAINS[@]}"; do
    while true; do
        IP=$(dig +short $DOMAIN)
        if [ -n "$IP" ]; then
            if [ "$IP" == "$VM_IP" ]; then
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