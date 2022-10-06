#!/bin/bash
echo "sherpa server starting..."
cd /workspace/my_website/sherpa
./sherpa/bin/lstm_transducer_stateless/streaming_server.py \
  --endpoint.rule3.min-utterance-length=1000.0 \
  --port 6006 \
  --max-batch-size 50   --max-wait-ms 5 \
  --nn-pool-size 1 \
  --nn-encoder-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/encoder_jit_trace-iter-472000-avg-18.pt \
  --nn-decoder-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/decoder_jit_trace-iter-472000-avg-18.pt \
  --nn-joiner-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/joiner_jit_trace-iter-472000-avg-18.pt  \
  --bpe-model-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/data/lang_bpe_500/bpe.model
