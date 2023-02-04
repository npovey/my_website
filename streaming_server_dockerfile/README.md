Step 0: AWS setup [Note using a CPU not GPU for demo purposes]
- Amazon Machine Image: Get AWS Deep Learning AMI GPU PyTorch 1.13.1 (Ubuntu 20.04) 20230103  [64-bit (x86)]
- Instance type: t3.large
   	- vCPUs: 2
   	- Memory (GiB): 8.0
   	- On-Demand Price/hr*: $0.0835

 - NOTE: tried t3.medium and during Dockerfile build the machine is running out of memmory.
    - Memory (GiB): 4.0 

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

Step 5: Check image size

```bash
docker image ls
```

| EPOSITORY | TAG  |  IMAGE ID | CREATED  |  SIZE |
| --- | --- | --- | --- | --- |
| sherpa_server    | latest  |  1336a33b2a8a  | 5 hours ago  | 39.8GB |
| nvcr.io/nvidia/pytorch  | 22.12-py3  | 1d9a58a6fcf5 | 7 weeks ago  | 18.3GB |


Step 6: Check disk usage, I needed at least 70GB space for streaming server

```
df -h
```
Need ~70GB
```
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       117G   66G   51G  57% /
```




