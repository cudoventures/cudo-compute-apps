git clone --no-checkout https://github.com/langgenius/dify.git cudo-tmp
cd cudo-tmp
git sparse-checkout init
git sparse-checkout set /docker
git checkout
cd ..
cp -r cudo-tmp/docker docker
rm -rf cudo-tmp

yq eval '.services.ollama = {
  "image": "ollama/ollama",
  "volumes": [".volumes/ollama:/root/.ollama"],
  "ports": ["127.0.0.1:11434:11434"],
  "container_name": "ollama",
  "deploy": {
    "resources": {
      "reservations": {
        "devices": [{
          "driver": "nvidia",
          "count": "all",
          "capabilities": ["gpu"]
        }]
      }
    }
  }
}' -i docker/docker-compose.yaml

cp docker/.env.example docker/.env
echo "Ollama added to docker-compose.yaml"

tar -cf docker.tar -C cudo-tmp docker
