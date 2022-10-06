#!/bin/bash
screen -dm bash -c 'cd /mnt/speech1/nadira/stt/sherpa;
#kill -9 $(sudo lsof -ti :6006);
./sherpa/bin/lstm_transducer_stateless/streaming_server.py \
  --endpoint.rule3.min-utterance-length=1000.0 \
  --port 6006 \
  --max-batch-size 50   --max-wait-ms 5 \
  --nn-pool-size 1 \
  --nn-encoder-filename /mnt/speech1/nadira/stt/sherpa/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/encoder_jit_trace-iter-472000-avg-18.pt \
  --nn-decoder-filename /mnt/speech1/nadira/stt/sherpa/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/decoder_jit_trace-iter-472000-avg-18.pt \
  --nn-joiner-filename /mnt/speech1/nadira/stt/sherpa/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/exp/joiner_jit_trace-iter-472000-avg-18.pt  \
 --bpe-model-filename /mnt/speech1/nadira/stt/sherpa/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03/data/lang_bpe_500/bpe.model'


screen -dm bash -c 'cd /mnt/speech1/nadira/stt/sherpa/sherpa/bin/web;
#kill -9 $(sudo lsof -ti :6008);
python3 -m http.server 6008;'
