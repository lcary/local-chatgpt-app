# local-chatgpt-app

A complete LLM ChatBot UI and server, all running on your laptop (tested on macOS):

```mermaid
graph LR;
    subgraph laptop [Your Laptop Environment]
    ChatBot[ChatBot UI] -- HTTP --> LLM[LLM Web Server];
    end
```

 - Runs a ChatGPT-like LLM (e.g. Llama 2) locally (using [llama-cpp-python](https://github.com/abetlen/llama-cpp-python))
 - Runs a ChatGPT-like UI/app locally (using [chainlit](https://github.com/Chainlit/chainlit))

## Setup

This loosely follows the setup steps from https://llama-cpp-python.readthedocs.io/en/latest/install/macos/.

### Python Version

This code has been tested on Python version 3.9.16. [Pyenv](https://github.com/pyenv/pyenv) is a great way to
install Python.

### Python Library Installation

Set up a virtual environment and install Python requirements:

```
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
```

### Model Download

Model download command:
```
huggingface-cli download \
    TheBloke/Llama-2-7B-Chat-GGUF \
    llama-2-7b-chat.Q5_K_M.gguf \
    --local-dir ./models/llama-7b-chat/ \
    --local-dir-use-symlinks False
```

This model file format (GGUF) is used for running LLM inference on macOS.
To use a different model:
 1. Update the above download command to use a different huggingface repo
    and filename (must be in [GGUF](https://huggingface.co/models?sort=modified&search=gguf) format).
 3. Update the `run-server.sh` script's `MODEL` variable with the path to the `.gguf` file after download.

## Usage

### Model Server

In one terminal, activate the virtualenv and run the model server with:
```
./run-server.sh
```

This will run the Llama 7B chat model inference server (by default on port 8000).

### Chat UI

In another terminal, activate the virtualenv and run the UI with:
```
./run-ui.sh
```

This will open a ChatGPT-like UI in your browser using Chainlit (by default on port 8001),
connected to the inference server.

## Troubleshooting

### Llama Library File Override

It may be necessary to run the `llama_cpp.server` with an override configured for `LLAMA_CPP_LIB`
to the path of the `.dylib` file created in the environment by the `llama-cpp-python` package.
This can be found by running `find /path/to/venv -name '*.dylib'` in your venv (or Conda env).
Attempting to build the llama C++ from scratch using https://github.com/ggerganov/llama.cpp resulted in
a segmentation fault for me when running the `llama_cpp.server` module, so the library override
using a pre-built library file seems to be more stable.
