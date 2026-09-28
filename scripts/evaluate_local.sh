#!/usr/bin/env bash
set -euo pipefail

checkpoint="${1:-checkpoints/gaussians/final.pt}"

uv run python -m src.evaluation.render_metrics \
  --checkpoint "$checkpoint" \
  --val-ratio 0.10 \
  --test-ratio 0.10 \
  --output outputs/eval/render_eval_report.md

