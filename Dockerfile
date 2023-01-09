FROM ubuntu:20.04

ARG VERSION

RUN apt-get update && apt-get upgrade -y && apt-get install -qq --no-install-recommends -y \
    build-essential \
    cargo \
    curl \
    git \
    libffi-dev \
    libgmp-dev \
    libssl-dev \
    pkg-config \
    python3-dev \
    python3-pip \
    python3.8-venv

RUN git clone -b $VERSION https://github.com/eqlabs/pathfinder.git

RUN python3 -m pip install -U pip fastecdsa && python3 -m pip install -r pathfinder/py/requirements-dev.txt && python3 -m pip install -e pathfinder/py/.[dev]
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN $HOME/.cargo/bin/rustup update stable
RUN cd pathfinder/py && $HOME/.cargo/bin/cargo build --release --bin pathfinder

WORKDIR /pathfinder/py

ENTRYPOINT ["/root/.cargo/bin/cargo", "run", "--release", "--bin", "pathfinder", "--", "--ethereum.url"]
