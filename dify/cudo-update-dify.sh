rm -rf docker
rm docker.tar
git clone --no-checkout https://github.com/langgenius/dify.git cudo-tmp
cd cudo-tmp
git sparse-checkout init
git sparse-checkout set /docker
git checkout
cd ..
cp -r cudo-tmp/docker docker
rm -rf cudo-tmp

yq eval-all 'select(fileIndex == 0) * select(fileIndex == 1)' docker/docker-compose.yaml ollama.yaml -i

cp docker/.env.example docker/.env
echo "Ollama added to docker-compose.yaml"

tar -cf docker.tar docker
