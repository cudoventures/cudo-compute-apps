#!/bin/sh

# Wait for the ollama service to be ready
until curl -s http://ollama:11434/api/version; do
  echo "Waiting for ollama service to be ready..."
  sleep 5
done

echo "Ollama service is ready. Pulling model..."

# Run the curl command to pull the model
curl -X POST http://ollama:11434/api/pull -d '{
  "model": "qwq"
}'

# Run the curl command to pull the model
curl -X POST http://ollama:11434/api/pull -d '{
  "model": "minicpm-v"
}'

echo "Model pull request sent."
