FROM ubuntu:24.04

# タイムゾーン設定
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y curl git make libgl1-mesa-dev libglib2.0-0 gcc python3-pip && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Kaggle CLIインストール
RUN pip3 install kaggle

# Linuxbrewのインストール
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bashrc && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    brew update

# 作業ディレクトリ設定
WORKDIR /workspace
ENV PATH="/root/.cargo/bin/:${PATH}"

# uvのインストール
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# プロジェクトファイルをコピー
COPY .python-version pyproject.toml uv.lock README.md ./

# Pythonのバージョン固定と依存パッケージの同期
RUN uv python pin "$(cat .python-version)" && \
    uv sync --dev
