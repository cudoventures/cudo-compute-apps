# Triton Server

## What the app does
This can be run in a startup script or via an SSH terminal:
```shell
mkdir -p /cudo
echo AUTH_TOKEN=mytoken > /cudo/.env
wget -qO - https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/install-compose-service.sh | bash -s triton
```

This will install the compose.yaml as a service and [triton-cli](https://github.com/triton-inference-server/triton_cli)

## Loading a model
By default; the app is configured to poll the models directory for new models and load them into Triton. This can be configured differently below. To load a model you can either ssh on to the VM and download it manually or scp it across.
However, triton cli is installed so to quickly get started you can load a hugging face model by logging on to the VM and running this:

```shell
triton import -m gpt2
```

For gated models, you will need a Huggingface account and approval to use the model, then you will need to log on to the VM and log in to hugging face


By default the triton docker image is set to: nvcr.io/nvidia/tritonserver:25.01-py3 but you can change the type by editing the .env file in ``/cudo/.env``


To set the image to use the vllm backend edit the ``.env`` file to include a new environment variable called ``TRITON_IMAGE``
```shell
AUTH_TOKEN=yourtoken
TRITON_MODEL_CONTROL_MODE=poll
TRITON_IMAGE=25.01-vllm-python-py3
```

You can also change the mode control mode, this is how Triton server knows when to laod a model from your model directory.




Models need to be saved ``/root/models``, you can download them yourself or scp them across, but an easy way to load a model is to use triton-cli.



To load a model you will need to ssh on to the server and run ```triton import ```



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