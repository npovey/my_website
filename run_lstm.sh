#!/bin/bash
echo "sherpa server starting..."
# cd /workspace/my_website/sherpa
#./sherpa/bin/lstm_transducer_stateless/streaming_server.py \

./sherpa/sherpa/bin/lstm_transducer_stateless/streaming_server.py \
  --endpoint.rule3.min-utterance-length=1000.0 \
  --port 6006 \
  --max-batch-size 50   --max-wait-ms 5 \
  --nn-pool-size 1 \
  --nn-encoder-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/giga/encoder_jit_trace-iter-468000-avg-16-giga.pt \
  --nn-decoder-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/giga/decoder_jit_trace-iter-468000-avg-16-giga.pt \
  --nn-joiner-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/giga/joiner_jit_trace-iter-468000-avg-16-giga.pt  \
  --bpe-model-filename /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/data/lang_bpe_500/bpe.model
