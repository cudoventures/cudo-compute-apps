# Ollama LLM inference server
You will need to:

- decide on an API key / token for your LLM sever
- choose a deepseek model version i.e. deepseek-r1:7b
- start a VM with a GPU large enough for the model

## Start a VM
- Memory 16-32GB RAM is suitable for most single GPU setups, if using larger/multiple GPUs it is wise to set system memory to 0.5x or 1x total GPU VRAM
- CPU 8-16 vCPUs is suitable for single GPU setups, but generally vCPU set to 0.5x Memory works well
- A suitably large boot disk 100GB + your model size if significant
- Choose **Ubuntu 22.04 + NVIDIA drivers + Docker** OS image

### Choosing a GPU

This table shows the approximate GPU VRAM requirements for different DeepSeek-R1 models @ 4bit quantization and the recommended GPU for running them.

| Model   | VRAM Required | Recommended GPU        |
|---------|---------------|------------------------|
| 1.5B    | 1.1GB         | 16GB A4000             |
| 7B      | 4.7GB         | 16GB A4000             |
| 8B      | 4.9GB         | 16GB A4000             |
| 14B     | 9GB           | 16GB A4000/ 24GB A5000 |
| 32B     | 20GB          | 48GB A40/A6000         |
| 70B     | 43GB          | 80GB A100/H100         |

## Install the inference service
This can be run in a startup script or via an SSH terminal, be sure to change ``YOUR_TOKEN`` to your desired ``api_key``. 

```shell
mkdir -p /cudo
echo AUTH_TOKEN=YOUR_TOKEN > /cudo/.env
wget -qO - https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/install-compose-service.sh | bash -s ollama
```

## Pull the model
You need the IP address of your VM and the token generated at deployment.

Use curl from your local machine to pull a model. The full model list is here: [Ollama library](https://ollama.com/library)
The model needs to fit on your GPU memory and VM Disk.

Here we will use deepseek-r1 7B:
```shell
curl --header "Authorization: Bearer YOUR_TOKEN" http://192.0.0.0:8080/api/pull -d '{"model": "deepseek-r1:7b"}'
```

You can continue using curl or any other REST tool: [API docs](https://github.com/ollama/ollama/blob/main/docs/api.md)


## Use OpenAI python client for inference 
> **Note:** OpenAI compatibility is experimental and is subject to major adjustments including breaking changes. For fully-featured access to the Ollama API, see the Ollama [Python library](https://github.com/ollama/ollama-python), [JavaScript library](https://github.com/ollama/ollama-js) and [REST API](https://github.com/ollama/ollama/blob/main/docs/api.md).
>

Now the model is ready, you can use openai python library: 

```shell
pip install openai
```

```python
from openai import OpenAI

ip = "192.0.0.0" # Your VM ip address goes here

client = OpenAI(
    base_url='http://'+ ip +':8080/v1/',

    # required but ignored
    api_key='YOUR_TOKEN', # Your api token goes here
)

list_completion = client.models.list()
print(list_completion.data)

response = client.chat.completions.create(
  model="deepseek-r1:7b",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Who won the world series in 2020?"},
    {"role": "assistant", "content": "The LA Dodgers won in 2020."},
    {"role": "user", "content": "Where was it played?"}
  ]
)
print(response.choices[0].message.content)
```
See more here: [OpenAI docs](https://github.com/ollama/ollama/blob/main/docs/openai.md)
