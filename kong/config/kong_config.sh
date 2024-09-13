## UI

curl -X POST http://kong:8001/services \
      --data name=admin-ui \
      --data host=kong \
      --data port=8002 && echo

curl -X POST http://kong:8001/services/admin-ui/routes \
      --data paths[]=/admin-ui && echo

curl -X POST http://kong:8001/routes/admin-ui/plugins \
  --data name=basic-auth && echo

curl -X POST http://kong:8001/consumers \
  --data username=kong-user && echo

curl -X POST http://kong:8001/consumers/kong-user/basic-auth \
  --data username=kong \
  --data password=env_password

## API
curl -X POST http://kong:8001/services \
      --data name=admin-api \
      --data host=kong \
      --data port=8001 && echo

curl -X POST http://kong:8001/services/admin-api/routes \
      --data paths[]=/admin-api && echo

curl -X POST http://kong:8001/routes/admin-api/plugins \
  --data name=key-auth \
  --data config.key_names=apikey && echo

curl -X POST http://kong:8001/consumers/kong-user/key-auth \
  --data key=env_password

