#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 CHECKPOINT 'COLMAP_POSE_LINE' OUTPUT_DIR" >&2
  exit 2
fi

checkpoint="$1"
pose_line="$2"
output_dir="$3"

mkdir -p "$output_dir"
uv run python -m src.gaussian_splatting.render \
  --checkpoint "$checkpoint" \
  --pose-line "$pose_line" \
  --out-rgb "$output_dir/rgb.png" \
  --out-sem "$output_dir/semantic.png"

