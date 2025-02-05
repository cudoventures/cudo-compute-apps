# VLLM LLM inference server

This can be run in a startup script or via an SSH terminal:
```shell
mkdir -p /cudo
echo HUGGING_FACE_HUB_TOKEN==hf_XXXXX > /cudo/.env
echo VLLM_API_KEY=mytoken >> /cudo/.env 
echo HUGGING_FACE_MODEL=mistralai/Mistral-7B-v0.1 >> /cudo/.env 
wget -qO - https://raw.githubusercontent.com/cudoventures/cudo-compute-apps/refs/heads/main/install-compose-service.sh | bash -s vllm
```

You need the IP address of your VM and the VLLM_API_KEY.

HUGGING_FACE_MODEL needs to e set to a hugging face model id. The supported model list is here: [VLLM models](https://docs.vllm.ai/en/latest/models/supported_models.html)
The model needs to fit on your GPU memory and VM Disk.


# OpenAI
> **Note:** OpenAI compatibility is experimental and is subject to major adjustments including breaking changes. For fully-featured access to the Ollama API, see the Ollama [Python library](https://github.com/ollama/ollama-python), [JavaScript library](https://github.com/ollama/ollama-js) and [REST API](https://github.com/ollama/ollama/blob/main/docs/api.md).
>

Now the model is ready, you can use openai python library: 

```shell
pip install openai
```

```python
ip  = "192.0.0.0"
 

from openai import OpenAI
client = OpenAI(
    base_url="http://"+ip+":8000/v1",
    api_key="YOUR_TOKEN",
)

completion = client.chat.completions.create(
  model="NousResearch/Meta-Llama-3-8B-Instruct",
  messages=[
    {"role": "user", "content": "Hello!"}
  ]
)

print(completion.choices[0].message)
```
See more here: [OpenAI docs](https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html)

Or you can use non-openai format 