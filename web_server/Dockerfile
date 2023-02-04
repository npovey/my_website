from nvcr.io/nvidia/pytorch:22.12-py3
ARG DEBIAN_FRONTEND=noninteractive
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

RUN pip install kaldiio graphviz
# https://docs.nvidia.com/deeplearning/frameworks/support-matrix/index.html
# Please choose previous pytorch:xx.xx if you encounter cuda driver mismatch issue
RUN pip3 install torchaudio
RUN pip3 install \
    k2==1.23.3.dev20230105+cuda11.7.torch1.13.1 -f https://k2-fsa.org/nightly/
# #install k2 from source
# #"sed -i ..."  line tries to turn off the cuda check
# RUN git clone https://github.com/k2-fsa/k2.git && \
#     cd k2 && \
#     sed -i 's/FATAL_ERROR/STATUS/g' cmake/torch.cmake && \
#     sed -i 's/in running_cuda_version//g' get_version.py && \
#     python3 setup.py install && \
#     cd -
WORKDIR /workspace

RUN git clone https://github.com/k2-fsa/icefall.git
ENV PYTHONPATH "${PYTHONPATH}:/workspace/icefall"
# https://github.com/k2-fsa/icefall/issues/674
ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION "python"

RUN git clone https://github.com/k2-fsa/sherpa.git && \
    cd sherpa && \
    pip3 install -r ./requirements.txt && \
    python3 setup.py bdist_wheel && \
    pip3 install ./dist/k2_sherpa-*.whl --force

ENV PYTHONPATH "${PYTHONPATH}:/workspace/sherpa"

RUN mkdir k2_models
RUN apt-get update
RUN apt-get install git-lfs
RUN git lfs install
RUN git clone https://huggingface.co/csukuangfj/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03 k2_models/icefall-asr-librispeech-lstm-transducer-stateless2-2022-09-03
RUN git clone https://github.com/npovey/my_website.git
ENV PYTHONPATH "${PYTHONPATH}:/workspace/my_website"
# EXPOSE 6006 <-streaming_server
EXPOSE 6008
#RUN ./my_website/run_lstm.sh

WORKDIR /workspace/sherpa
ENTRYPOINT ["/workspace/my_website/run_web.sh"]
