FROM mambaorg/micromamba 

ARG MAMBA_DOCKERFILE_ACTIVATE=1

USER root

RUN sed -i 's/http/https/g' /etc/apt/sources.list.d/debian.sources && \
    apt update && apt install -y curl

USER $MAMBA_USER

RUN curl https://ccsb.scripps.edu/mamba/scripts/adcpsuite.sh -o adcpsuite.sh && \
    chmod +x ./adcpsuite.sh

RUN micromamba shell init --shell bash

RUN ln -s ./mamba.sh /opt/conda/etc/profile.d/micromamba.sh && \
    bash -c ". ~/.bashrc && ./adcpsuite.sh" && \
    echo "\n Test https://ccsb.scripps.edu/mamba/pip/py37/ \n" && \
    bash -c "curl -Lv https://ccsb.scripps.edu/mamba/pip/py37/" && \
    echo "\n Test https://ccsb.scripps.edu/mamba/pip/py37/legacy \n" && \
    bash -c "curl -Lv https://ccsb.scripps.edu/mamba/pip/py37/legacy"
