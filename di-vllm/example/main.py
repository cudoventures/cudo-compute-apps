from openai import OpenAI

client = OpenAI(
    base_url="https://vm-id.project-id.cudo.dev/v1", # remember the /v1
    api_key="password",
)

completion = client.chat.completions.create(
    model="RedHatAI/gemma-3-1b-it-FP8-dynamic",
    messages=[
        {"role": "user", "content": "How big is the universe?"},
    ])


print(completion.choices[0].message)
