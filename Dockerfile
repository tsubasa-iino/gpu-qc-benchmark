# ベースイメージは 'base' ではなく 'devel'  (nvcc やライブラリ一式を含む)
FROM nvidia/cuda:12.6.0-devel-ubuntu22.04

# 対話モード防止
ENV DEBIAN_FRONTEND=noninteractive

# システムパッケージのインストール
# build-essential: C++コンパイラ(g++)などのビルド必須ツール
# libgl1-mesa-glx: matplotlibの表示 (GUI/Backend) で必要になることが多いライブラリ
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    build-essential \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# upgrade pip and install latest CMake
# aptだと古いバージョンのCMakeになる
RUN pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir cmake

# Pythonライブラリ
RUN pip3 install --no-cache-dir \
    numpy \
    pandas \
    jupyterlab \
    matplotlib \
    seaborn

# GPU4PySCF用ライブラリ
RUN pip3 install --no-cache-dir \
    gpu4pyscf-cuda12x

# pip3 install cutensor-cu12 では最新版がインストールされるが
# gpu4pyscf-cuda12xの裏で自動的にダウンロードされるビルド済みcupy-cuda12xのバージョンに合わせる必要がある
# 下記CuPy公式組み込みツールでビルド時に使用されていたバージョンのcuTENSORを直接NVIDIAからダウンロードする
RUN python3 -m cupyx.tools.install_library --cuda 12.x --library cutensor

# 環境変数の設定 (念のためパスを通す + CuPyに確実にcuTENSORを使わせる)
ENV PATH=/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
ENV CUPY_ACCELERATORS=cub,cutensor

# 作業ディレクトリ設定
WORKDIR /workspace

# デフォルトでシェル起動
CMD ["/bin/bash"]