# gpu-qc-benchmark

GPUを用いた量子化学計算のベンチマーク用Jupyter環境

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
