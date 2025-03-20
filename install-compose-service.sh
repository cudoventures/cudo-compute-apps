#!/bin/bash
REPO_URL=https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 {jupyter|jupyter-pytorch|jupyter-tensorflow|vllm|ollama|triron}"
  exit 1
fi

#Load env variables from .env

if [ -f /cudo/.env ]; then
  export $(grep -v '^#' /cudo/.env | xargs)
else
  echo "[!] .env file not found!"
fi

# Argument passed to the script
option=$1

# Switch case to handle different options
case $option in
  jupyter)
    echo "Setting up Jupyter environment..."
    mkdir /cudo
    wget -O /cudo/compose.yaml ${REPO_URL}/jupyter/compose.yaml
    wget -O /etc/systemd/system/cudo.service ${REPO_URL}/cudo.service
    systemctl daemon-reload
    systemctl enable cudo.service
    systemctl start cudo.service

    # Add commands to set up Jupyter
    ;;
  jupyter-pytorch)
    echo "Setting up Jupyter with PyTorch..."
    ;;
  jupyter-tensorflow)
    echo "Setting up Jupyter with TensorFlow..."
    ;;
  vllm)
    echo "Setting up VLLM environment..."
    mkdir -p /cudo
    wget -O /cudo/compose.yaml ${REPO_URL}/vllm/compose.yaml

    wget -O /etc/systemd/system/cudo.service ${REPO_URL}/cudo.service
    systemctl daemon-reload
    systemctl enable cudo.service
    systemctl start cudo.service
    ;;
  ollama)
    echo "Setting up Ollama environment..."
    mkdir -p /cudo
    wget -O /cudo/compose.yaml ${REPO_URL}/ollama/compose.yaml
    wget -O /cudo/nginx.conf ${REPO_URL}/ollama/nginx.conf
    sed -i "s/CUDO_TOKEN/${AUTH_TOKEN}/g" /cudo/nginx.conf

    wget -O /etc/systemd/system/cudo.service ${REPO_URL}/cudo.service
    systemctl daemon-reload
    systemctl enable cudo.service
    systemctl start cudo.service
    ;;
  openmanus)
    echo "Setting up OpenManus environment..."
    mkdir -p /cudo
    wget -O /cudo/compose.yaml ${REPO_URL}/openmanus/compose.yaml
    wget -O /cudo/poll_and_pull.sh ${REPO_URL}/openmanus/poll_and_pull.sh
    chmod +x /cudo/poll_and_pull.sh
    wget -O /cudo/openmanus.sh ${REPO_URL}/openmanus/openmanus.sh
    wget -O /etc/systemd/system/cudo.service ${REPO_URL}/cudo.service
    systemctl daemon-reload
    systemctl enable cudo.service
    systemctl start cudo.service
    echo "Installing OpenManus..."
    chmod +x /cudo/openmanus.sh
    /cudo/openmanus.sh
    touch ~/openmanus-is-ready
    ;;
  triton)
    echo "Setting up Triton environment..."
    mkdir -p /cudo
    wget -O /cudo/compose.yaml ${REPO_URL}/triton/compose.yaml
    wget -O /cudo/nginx.conf ${REPO_URL}/triton/nginx.conf
    sed -i "s/CUDO_TOKEN/${AUTH_TOKEN}/g" /cudo/nginx.conf
    pip install git+https://github.com/triton-inference-server/triton_cli.git

    wget -O /etc/systemd/system/cudo.service ${REPO_URL}/cudo.service
    systemctl daemon-reload
    systemctl enable cudo.service
    systemctl start cudo.service
    ;;
  *)
    echo "Invalid option. Usage: $0 {jupyter|jupyter-pytorch|jupyter-tensorflow|vllm|ollama}"
    exit 1
    ;;
esac