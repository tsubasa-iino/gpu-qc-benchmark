# gpu-qc-benchmark

GPUを用いた量子化学計算プログラムの実行速度ベンチマーク

## 必須環境
- Docker (および Docker Compose プラグイン)
- NVIDIA Container Toolkit（コンテナからGPUを認識するために必須）

## 使い方

1. コンテナをバックグラウンドで起動
   ```bash
   docker compose up -d
   ```

2. ログを表示しJupyter LabへのアクセスURL（`http://127.0.0.1:8888/lab?token=...` などの行）を確認
   ```bash
   docker compose logs
   ```

3. ブラウザで確認したURLにアクセス

## 終了方法

以下のコマンドでコンテナを停止・削除
   ```bash
   docker compose down
   ```

---

## `benchmark.ipynb` の説明

量子化学計算プログラム [GANSU](https://www.hiroshima-u.ac.jp/news/89271) ([参考ブログ](https://blog.fltech.dev/entry/2025/03/27/gansu-ja)) と [GPU4PySCF](https://pyscf.org/user/gpu.html) ([参考論文](https://arxiv.org/abs/2404.09452)) の実行速度の比較をしたNotebook

### 実行内容
アルカン分子（炭素鎖 C1 - C8）を対象に以下の計算手法でエネルギー計算を実施
* **計算手法**: HF/STO-3G, CCSD/STO-3G

### 使用した計算環境
* **CPU**: AMD Ryzen 5 3600 6-Core Processor
* **GPU**: NVIDIA GeForce RTX 3060 Ti

### Google Colabでの実行について
NotebookはDocker環境を構築せずとも Google Colab 上で完結して実行可能

> **注意**\
> GANSUは NVIDIA T4 GPU には非対応\
> Google Colabで実行するには有料プランを利用して**CUDA Compute Capability 8.0 以上**を満たすGPUのランタイムを選択する必要あり
