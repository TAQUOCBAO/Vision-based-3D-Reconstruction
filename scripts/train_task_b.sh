#!/usr/bin/env bash
set -euo pipefail

uv run python -m src.gaussian_splatting.train \
  --iters 40000 \
  --downsample 1.0 \
  --lambda-sem 0.5 \
  --val-ratio 0.10 \
  --test-ratio 0.10 \
  --seed 42 \
  --output-dir outputs/checkpoints/gaussians

