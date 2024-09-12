# Triton Server Quick Start
This app adds authentication to triton server, therefore the usual ports have different endpoints:

:8000 (http) becomes: :80/triton-http 
8001 (grpc) becomes: :9080/triton-grpc
8002 (metrics) become :80/triton-metrics

Once the serevr is up an running, you could normally do a health check using curl. However this needs to be modified to the second version:

Incorrect method:
```shell
curl -v  CUDO_IP_ADDRESS:8000/v2/health/ready
```
Correct method:
```shell
curl -v --header "apikey: my-key" 198.145.104.33/triton/v2/health/ready
```

# Python
To use this with python and http see the following example, note that we need to make a plugin with the key/password set in the Cudo console when creating the app.
This plugin is then registered with the triton client so it can call triton server with the correct authentication key.

```shell
pip install tritonclient
```

```python
import tritonclient.http as httpclient
from tritonclient.utils import InferenceServerException

IP_ADDRESS = '198.145.104.33'
KEY = 'my-key'

class AuthKeyPlugin():
  def __call__(self, request):
       request.headers['apikey'] = KEY
    
triton_client = httpclient.InferenceServerClient(url=IP_ADDRESS + '/triton-http')
auth_plugin = AuthKeyPlugin()
triton_client.register_plugin(auth_plugin)

...

results = triton_client.infer(model_name=model_name, inputs=inputs, outputs=outputs)
```

# Node and Python GRPC
More complete Node and python examples are in the ``client_examples`` directory of this readme.