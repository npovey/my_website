Step 0: AWS setup [Note using a CPU not GPU for demo purposes]
- Amazon Machine Image: Get AWS Deep Learning AMI GPU PyTorch 1.13.1 (Ubuntu 20.04) 20230103  [64-bit (x86)]
- Instance type: t3.large
   	- vCPUs: 2
   	- Memory (GiB): 8.0
   	- On-Demand Price/hr*: $0.0835

 - NOTE: tried t3.medium and during Dockerfile build the machine is running out of memmory.
    - Memory (GiB): 4.0 

Step 1: Building streaming server image takes an hour
```bash
docker build . -f Dockerfile -t sherpa_server:latest
```

Step 2: Find image id

```bash
docker image ls
```

| EPOSITORY | TAG  |  IMAGE ID | CREATED  |  SIZE |
| --- | --- | --- | --- | --- |
| sherpa_server    | latest  |  16b9eb93e298  | 5 hours ago  | 39.8GB |
| nvcr.io/nvidia/pytorch  | 22.12-py3  | 1d9a58a6fcf5 | 7 weeks ago  | 18.3GB |


Step 3: Start image

```bash
docker run 16b9eb93e298  ls -la
```


```
ubuntu@ip:~$ sudo docker run 16b9eb93e298  ls -la
sherpa server starting...
2023-02-04 03:27:51,543 INFO [streaming_server.py:649] {'decoding_method': 'greedy_search', 'beam': 10.0, 'num_paths': 200, 'num_active_e': 0.5, 'temperature': 1.0, 'max_contexts': 8, 'max_states': 32, 'lang_dir': PosixPath('data/lang_bpe_500'), 'ngram_lm_scale': 0.01}
2023-02-04 03:27:51,544 INFO [streaming_server.py:652] {'endpoint_rule1_must_contain_nonsilence': False, 'endpoint_rule1_min_trailing_si_rule1_min_utterance_length': 0.0, 'endpoint_rule2_must_contain_nonsilence': True, 'endpoint_rule2_min_trailing_silence': 2.0, 'endpointength': 0.0, 'endpoint_rule3_must_contain_nonsilence': False, 'endpoint_rule3_min_trailing_silence': 0.0, 'endpoint_rule3_min_utterance_
2023-02-04 03:27:51,544 INFO [streaming_server.py:658] {'decoding_method': 'greedy_search', 'beam': 10.0, 'num_paths': 200, 'num_active_e': 0.5, 'temperature': 1.0, 'max_contexts': 8, 'max_states': 32, 'lang_dir': PosixPath('data/lang_bpe_500'), 'ngram_lm_scale': 0.01, 'etain_nonsilence': False, 'endpoint_rule1_min_trailing_silence': 5.0, 'endpoint_rule1_min_utterance_length': 0.0, 'endpoint_rule2_must_coe, 'endpoint_rule2_min_trailing_silence': 2.0, 'endpoint_rule2_min_utterance_length': 0.0, 'endpoint_rule3_must_contain_nonsilence': Faln_trailing_silence': 0.0, 'endpoint_rule3_min_utterance_length': 1000.0, 'port': 6006, 'nn_encoder_filename': '/workspace/k2_models/iceftm-transducer-stateless2-2022-09-03/exp/giga/encoder_jit_trace-iter-468000-avg-16-giga.pt', 'nn_decoder_filename': '/workspace/k2_modelsch-lstm-transducer-stateless2-2022-09-03/exp/giga/decoder_jit_trace-iter-468000-avg-16-giga.pt', 'nn_joiner_filename': '/workspace/k2_mospeech-lstm-transducer-stateless2-2022-09-03/exp/giga/joiner_jit_trace-iter-468000-avg-16-giga.pt', 'bpe_model_filename': '/workspace/k2brispeech-lstm-transducer-stateless2-2022-09-03/data/lang_bpe_500/bpe.model', 'token_filename': None, 'nn_pool_size': 1, 'max_batch_size5.0, 'max_message_size': 1048576, 'max_queue_size': 32, 'max_active_connections': 500, 'certificate': None, 'doc_root': './sherpa/bin/we
2023-02-04 03:27:51,547 INFO [streaming_server.py:280] Using device: cpu
2023-02-04 03:27:51,992 INFO [streaming_server.py:364] Warmup start
2023-02-04 03:27:53,153 INFO [streaming_server.py:378] Warmup done
2023-02-04 03:27:53,153 INFO [streaming_server.py:473] No certificate provided
2023-02-04 03:27:53,154 INFO [server.py:713] server listening on 0.0.0.0:6006
2023-02-04 03:27:53,155 INFO [server.py:713] server listening on [::]:6006
2023-02-04 03:27:53,158 INFO [streaming_server.py:490] Please visit one of the following addresses: 

  http://0.0.0.0:6006
  http://localhost:6006
  http://127.0.0.1:6006
  http://172.17.0.2:6006

```


### The steps below are needed if things go wrong and we need manual execution

Step 3: Start container

```bash
docker start eager_jemison
```

Step 4: Get into container

```bash
docker exec -it eager_jemison /bin/bash
```

Step 5: execute script

```
root@7e1e67c6fffb:/workspace/sherpa# /workspace/my_website/run_lstm.sh
```


### How to Check Disk Usage:

I needed at least 70GB space for streaming server

```bash
df -h
```

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       117G   66G   51G  57% /
```

