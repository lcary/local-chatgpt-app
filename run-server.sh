MODEL=models/llama-7b-chat/llama-2-7b-chat.Q5_K_M.gguf
python3 -m llama_cpp.server --model $MODEL
