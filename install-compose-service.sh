#!/bin/bash
REPO_URL=https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 {jupyter|jupyter-pytorch|jupyter-tensorflow|vllm|ollama}"
  exit 1
fi

# Argument passed to the script
option=$1

# Switch case to handle different options
case $option in
  jupyter)
    echo "Setting up Jupyter environment..."
    mkdir /work
    wget -P /compose.yaml ${REPO_URL}/ollama/compose.yaml
    wget -P /docker-compose.service ${REPO_URL}/docker-compose.service
    systemctl daemon-reload
    systemctl enable docker-compose.service

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
    ;;
  ollama)
    echo "Setting up Ollama environment..."
    wget -P /compose.yaml ${REPO_URL}/ollama/compose.yaml
    wget -P /nginx.conf ${REPO_URL}/ollama/nginx.conf
    wget -P /docker-compose.service ${REPO_URL}/docker-compose.service
    systemctl daemon-reload
    systemctl enable docker-compose.service

    ;;
  *)
    echo "Invalid option. Usage: $0 {jupyter|jupyter-pytorch|jupyter-tensorflow|vllm|ollama}"
    exit 1
    ;;
esac