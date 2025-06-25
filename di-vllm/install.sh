#!/bin/bash
REPO_URL=https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main


apt update
apt install htpasswd git

mkdir /cudo
cd /cudo
git init
git remote add origin https://github.com/cudoventures/cudo-compute-apps.git
git config core.sparseCheckout true
echo "di-vllm/" >> .git/info/sparse-checkout
git pull origin main
