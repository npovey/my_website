Step 1: Build image take an hour
```
docker build . -f Dockerfile -t sherpa_server:latest
```

Step 2: Start container

```
docker start eager_jemison
```

Step 3: Get into container

```
docker exec -it eager_jemison /bin/bash
```

Step 4: execute script

```
root@7e1e67c6fffb:/workspace/sherpa# /workspace/my_website/run_lstm.sh
```



```bash
docker image ls
```

| EPOSITORY | TAG  |  IMAGE ID | CREATED  |  SIZE |
| --- | --- | --- | --- | --- |
| sherpa_server    | latest  |  1336a33b2a8a  | 5 hours ago  | 39.8GB |
| nvcr.io/nvidia/pytorch  | 22.12-py3  | 1d9a58a6fcf5 | 7 weeks ago  | 18.3GB |
