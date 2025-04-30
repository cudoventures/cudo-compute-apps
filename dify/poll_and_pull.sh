#!/bin/sh

if [ -f .cudo-env ]; then
  export $(grep -v '^#' .cudo-env | xargs)
fi

# Wait for the ollama service to be ready
until curl -s http://ollama:11434/api/version; do
  echo "Waiting for ollama service to be ready..."
  sleep 5
done

echo "Ollama service is ready. Pulling model..."

# Run the curl command to pull the model
curl -X POST http://ollama:11434/api/pull -d "{
  \"model\": \"$REASONING_MODEL\"
}"

# Run the curl command to pull the model
curl -X POST http://ollama:11434/api/pull -d '{
  "model": "linux6200/bge-reranker-v2-m3"
}'

# Run the curl command to pull the model
curl -X POST http://ollama:11434/api/pull -d '{
  "model": "nomic-embed-text"
}'

echo "Model pull request sent."
