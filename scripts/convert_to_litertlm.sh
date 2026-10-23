#!/usr/bin/env bash
# GokkoModel: Qwen2.5-0.5B-Instruct -> GokkoModel.litertlm
# Gereksinimler: Python 3.10+, ~8 GB bos disk, en az 8 GB RAM onerilir.
# Requirements: Python 3.10+, ~8 GB free disk, 8 GB RAM recommended.
set -euo pipefail

WORKDIR="${1:-/tmp/gokkomodel-litertlm}"
echo "==> Calisma dizini / workdir: $WORKDIR"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "==> Paketler kuruluyor / installing packages"
pip install --quiet torch --index-url https://download.pytorch.org/whl/cpu
pip install --quiet litert-torch

echo "==> Taban model indiriliyor / downloading base model"
CKPT=$(python3 -c "from huggingface_hub import snapshot_download; print(snapshot_download('Qwen/Qwen2.5-0.5B-Instruct'))")
echo "==> Checkpoint: $CKPT"

echo "==> Chat template'e GokkoModel kimligi gomuluyor / baking identity"
python3 "$(dirname "$0")/patch_chat_template.py" "$CKPT"

echo "==> .litertlm uretiliyor / exporting (birkac dakika surebilir)"
litert-torch export_hf --model="$CKPT" --output_dir="$WORKDIR/out" --use_jinja_template=True -q dynamic_int8

LITERTLM=$(ls "$WORKDIR"/out/*.litertlm | head -1)
mv "$LITERTLM" "$WORKDIR/GokkoModel.litertlm"
echo "==> Bitti / done: $WORKDIR/GokkoModel.litertlm"
ls -la "$WORKDIR/GokkoModel.litertlm"
python3 -m zipfile -l "$WORKDIR/GokkoModel.litertlm" || true
