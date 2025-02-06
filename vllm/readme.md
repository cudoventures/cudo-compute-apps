# VLLM LLM inference server

This can be run in a startup script or via an SSH terminal:
```shell
mkdir -p /cudo
echo HUGGING_FACE_HUB_TOKEN=hf_XXXXX > /cudo/.env
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
from openai import OpenAI

client = OpenAI(
    api_key="YOUR_TOKEN",
    base_url="http://194.0.0.0:8000/v1",
)

models = client.models.list()
print(f"Available models: {models.data}")
model = models.data[0].id

# Completion API
stream = False
completion = client.completions.create(
    model=model,
    prompt="A robot may not injure a human being",
    echo=False,
    n=2,
    stream=stream,
    logprobs=3)

print("Completion results:")
if stream:
    for c in completion:
        print(c)
    for c in completion:
        if c.choices:
            print(c.choices[0].text)
else:
    print(completion)
    for choice in completion.choices:
        print(choice.text)
```
See more here: [OpenAI docs](https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html)
