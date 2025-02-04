# Installing an app:

```shell
mkdir -p /cudo
echo AUTH_TOKEN=CUDO_TOKEN > /cudo/.env
wget -qO - https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/install-compose-service.sh | bash -s ollama
```
