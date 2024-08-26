# hash:sha256:47e47004e5e041605c4251b503ec5af8864683348dd4ef07cbd5fd3f6ecaa9f8
FROM registry.apps.codeocean.com/codeocean/mambaforge3:22.11.1-4-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates=20230311ubuntu0.22.04.1 \
        git=1:2.34.1-1ubuntu1.10 \
    && rm -rf /var/lib/apt/lists/*

RUN mamba install -y --channel=bioconda --channel=conda-forge \
        star==2.7.11a \
    && mamba clean -ya

RUN pip install -U --no-cache-dir \
    code-ocean-aux-tools==1.1.3

COPY postInstall /
RUN /postInstall
