FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-devel

# ENV http_proxy=http://aaa.bbb.cc.net:8080 \
#	https_proxy=http://aaa.bbb.cc.net:8080 

# install normal source
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        g++ \
        make \
        automake \
        autoconf \
        bzip2 \
        unzip \
        wget \
        sox \
        libtool \
        git \
        subversion \
        zlib1g-dev \
        gfortran \
        ca-certificates \
        patch \
        ffmpeg \
	screen \
	nano \
        lsof \
        valgrind \
	libssl-dev \
	vim \
	curl

# cmake
RUN wget -P /opt https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz && \
    cd /opt && \
    tar -zxvf cmake-3.18.0.tar.gz && \
    cd cmake-3.18.0 && \
    ./bootstrap && \
    make && \
    make install && \
    rm -rf cmake-3.18.0.tar.gz && \
    find /opt/cmake-3.18.0 -type f \( -name "*.o" -o -name "*.la" -o -name "*.a" \) -exec rm {} \; && \
    cd -
	
# flac 
RUN wget -P /opt https://downloads.xiph.org/releases/flac/flac-1.3.2.tar.xz  && \
    cd /opt && \ 
    xz -d flac-1.3.2.tar.xz && \
    tar -xvf flac-1.3.2.tar && \
    cd flac-1.3.2 && \
    ./configure && \
    make && make install && \
    rm -rf flac-1.3.2.tar && \
    find /opt/flac-1.3.2  -type f \( -name "*.o" -o -name "*.la" -o -name "*.a" \) -exec rm {} \; && \
    cd - 

RUN pip install kaldiio graphviz && \
	conda install -y -c pytorch torchaudio

#install k2 from source
RUN git clone https://github.com/k2-fsa/k2.git /opt/k2 && \
    cd /opt/k2 && \
    python3 setup.py install && \
    cd -

# install  lhotse
RUN pip install git+https://github.com/lhotse-speech/lhotse

RUN git clone https://github.com/k2-fsa/icefall /workspace/icefall && \
	cd /workspace/icefall && \
	pip install -r requirements.txt


RUN git clone https://github.com/k2-fsa/sherpa /workspace/sherpa && \
        cd /workspace/sherpa && \
        pip install -r requirements.txt
	
RUN cd sherpa && python3 setup.py install --verbose
	
RUN mkdir /workspace/k2_models

RUN apt update

RUN apt install git-lfs
RUN git lfs install
RUN git clone https://huggingface.co/csukuangfj/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03 /workspace/k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03
RUN git clone https://github.com/npovey/my_website.git /workspace/my_website
ENV PYTHONPATH /workspace/my_website:$PYTHONPATH

WORKDIR /workspace/my_website
EXPOSE 6006
EXPOSE 6008
ENTRYPOINT ./run_lstm.sh
