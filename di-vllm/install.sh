#!/bin/bash
export DEBIAN_FRONTEND="noninteractive"
REPO_URL=https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main


apt update
apt install -y apache2-utils git

mkdir /cudo
cd /cudo
git init
git remote add origin https://github.com/cudoventures/cudo-compute-apps.git
git config core.sparseCheckout true
echo "di-vllm/" >> .git/info/sparse-checkout
git pull origin main
cp .env /cudo/di-vllm/
cd di-vllm
echo "HOST_IP=$(hostname -I | awk '{print $1}')" >> .env
docker compose up -d

