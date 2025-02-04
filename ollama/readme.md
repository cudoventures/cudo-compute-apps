# Ollama LLM inference server
You need the IP address of your VM and the token generated at deployment.

Use curl from your local machine to pull a model. Model list is here: [Ollama library](https://ollama.com/library)
The model needs to fit on your GPU memory and VM Disk.

```shell
curl --header "Authorization: Bearer YOUR_TOKEN" http://192.0.0.0:8080/api/pull -d '{"model": "tinyllama"}'
```
You can continue using curl or any other REST tool: [API docs](https://github.com/ollama/ollama/blob/main/docs/api.md)


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
    base_url='http://'+ ip +':8080/v1/',
    api_key='YOUR_TOKEN',
)

list_completion = client.models.list()


print(list_completion.data)
```
See more here: [OpenAI docs](https://github.com/ollama/ollama/blob/main/docs/openai.md)

Or you can use non-openai format 