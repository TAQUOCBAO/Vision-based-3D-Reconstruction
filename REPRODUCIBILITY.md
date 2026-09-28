# Reproducibility record

## Canonical artifacts and run

- Exact reported-result reproduction: supplied Task A and Task B checkpoints
- Canonical Task B supervision: supplied `outputs/gt_masks/` and `outputs/pseudo_masks/`
- Task B random seed: 42
- Labeled split: 240 train, 30 Task A validation, 30 final local test
- Task B supervision: 270 manual masks and 100 pseudo-masks
- Task A: SegFormer MiT-B0, 80 epochs, batch size 8, 512×384 training resolution
- Task B: 40,000 iterations, 1320×989 training resolution
- Semantic-loss weight: 0.5
- Pseudo-mask source weight: 0.5
- Hardware used for the reported run: NVIDIA RTX 3080, 10 GB

The 30 test images are excluded from Task A training and checkpoint selection, Task B losses,
semantic voting, sparse triangulation, and observed-color initialization.

The original Task A training run predates explicit deterministic seeding. Its exact trained state
is therefore preserved by the bundled checkpoint and SHA-256 checksum. Optional Task A retraining
can vary and writes regenerated pseudo-masks to a separate directory by default. Likewise, minor
Task B retraining differences can occur across CUDA devices and library builds. The reproducibility
target for the submitted numerical results is evaluation of the supplied canonical checkpoint.

## Expected local results

The supplied final checkpoint should reproduce approximately:

| Metric | Expected value |
|---|---:|
| PSNR | 22.43 dB |
| SSIM | 0.854 |
| LPIPS | 0.321 |
| Structural mIoU, four classes | 92.08% |

Small numerical differences may occur across CUDA devices and library builds.

## Verification sequence

1. Install the locked environment.
2. Run the unit tests.
3. Place the data and checkpoints according to `DATA_LAYOUT.md`.
4. Run `scripts/render_submission.sh` to verify the required RGB and class-ID outputs.
5. Run `scripts/evaluate_local.sh` to reproduce the local holdout report.
6. Treat retraining as an optional experiment; follow the separate workflows in the main README.

## Artifact checksums

The bundled checkpoint SHA-256 values are:

```text
Task A checkpoint: 1a746b492151e1eda5bb635b0223b536cbb8a979681b52f95c6ea2a823f14c82
Task B checkpoint: 22e0101f52d9b531f69193c695f577132c1c2cdc95c2b2d3ee0e2a1b3cc136b6
Code archive:      see the accompanying `SHA256SUMS.txt`
```
