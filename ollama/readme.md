Got to your <IP_ADDRESS>


https://github.com/ollama/ollama/blob/main/docs/api.md

from this:

curl http://localhost:11434/api/tags

to this:

curl  --header "apikey: key_auth_key"  http://tron:8000/api/tags

TODO:
see if I can write headers here:
https://github.com/ollama/ollama-python

https://github.com/ollama/ollama-js

also decide on which port to serve on 11434, 80 ?? or 8000
