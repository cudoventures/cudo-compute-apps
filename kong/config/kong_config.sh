
echo configure

# User

curl -X POST http://kong:8001/consumers \
  --data username=kong-user 

curl -X POST http://kong:8001/consumers/kong-user/key-auth \
  --data key=env_password

curl -X POST http://kong:8001/consumers/kong-user/basic-auth \
  --data username=kong \
  --data password=env_password

## UI
curl -X POST http://kong:8001/services \
      --data name=admin-ui \
      --data host=kong \
      --data port=8002 

curl -X POST http://kong:8001/services/admin-ui/routes \
      --data paths[]=/admin-ui \
      --data name=admin-ui-route 

curl -X POST http://kong:8001/routes/admin-ui-route/plugins \
  --data name=basic-auth 

## API
curl -X POST http://kong:8001/services \
      --data name=admin-api \
      --data host=kong \
      --data port=8001 

curl -X POST http://kong:8001/services/admin-api/routes \
      --data paths[]=/admin-api \
      --data name=admin-api-route 

curl -X POST http://kong:8001/routes/admin-api-route/plugins \
  --data name=key-auth \
  --data config.key_names=apikey 


