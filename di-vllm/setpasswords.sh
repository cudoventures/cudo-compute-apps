#!/bin/bash

# Load environment variables
source .env

# Generate hashed password
TRAEFIK_HASHED_PASSWORD=$(htpasswd -nb admin "$VLLM_API_KEY" | sed -e s/\\$/\\$\\$/g)

echo $TRAEFIK_HASHED_PASSWORD
# Output the hashed password
echo "TRAEFIK_HASHED_PASSWORD=$HTRAEFIK_HASHED_PASSWORD" >> .env