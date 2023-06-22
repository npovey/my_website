# trained on libri (~1K hours ) and giga (~10K hours)
cd /workspace/sherpa-onnx
echo "$PWD"
python3 ./python-api-examples/streaming_server.py \
   --port 6006 \
   --nn-pool-size 1 \
   --tokens /workspace/k2_models/sherpa-onnx-streaming-zipformer-en-2023-06-21/tokens.txt \
   --encoder-model /workspace/k2_models/sherpa-onnx-streaming-zipformer-en-2023-06-21/encoder-epoch-99-avg-1.onnx \
   --decoder-model /workspace/k2_models/sherpa-onnx-streaming-zipformer-en-2023-06-21/decoder-epoch-99-avg-1.onnx \
   --joiner-model /workspace/k2_models/sherpa-onnx-streaming-zipformer-en-2023-06-21/joiner-epoch-99-avg-1.onnx \
   --certificate /workspace/my_website/cert.pem
