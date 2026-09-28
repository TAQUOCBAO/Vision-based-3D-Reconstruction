#!/usr/bin/env bash
set -euo pipefail

uv run python -m src.segmentation.train \
  --epochs 80 \
  --batch-size 8 \
  --val-ratio 0.10 \
  --test-ratio 0.10 \
  --output-dir outputs/checkpoints/segformer_mitb0

