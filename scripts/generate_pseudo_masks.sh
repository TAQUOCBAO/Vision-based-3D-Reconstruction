#!/usr/bin/env bash
set -euo pipefail

checkpoint="${1:-checkpoints/segformer_mitb0/best.pt}"
output_dir="${2:-outputs/pseudo_masks_regenerated}"

if [[ ! -f "$checkpoint" ]]; then
  echo "SegFormer checkpoint not found: $checkpoint" >&2
  exit 2
fi

uv run python -m src.segmentation.infer \
  --checkpoint "$checkpoint" \
  --output-dir "$output_dir"
