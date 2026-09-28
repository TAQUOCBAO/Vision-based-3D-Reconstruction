# IC-SHM 2026 Project 2 — Reproducibility Package

This package contains the Python implementation of **Multi-View Semantic 3D Gaussian
Splatting for Component-Aware Bridge Reconstruction from UAV Imagery**.

The pipeline produces both outputs required by Project 2 from a query camera pose:

- an RGB render; and
- a semantic class-ID image with `0=background`, `1=deck`, `2=stay_cable`, `3=tower`, and
  `4=foundation`.

## 1. Environment

The tested environment is Python 3.10, CUDA 12.1, PyTorch 2.4.1, and gsplat 1.5.3.

```bash
uv sync --extra deeplearning
```

Run the included unit tests:

```bash
PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 uv run pytest -q
```

## 2. Data and checkpoints

Place the organizer-provided data under `data/Contest Dataset/` as described in
[`DATA_LAYOUT.md`](DATA_LAYOUT.md). The two canonical checkpoints are bundled under
`checkpoints/`; their SHA-256 checksums are recorded in `checkpoints/README.md`. The
separately distributed dataset archive and its checksum are documented in
`data/README.md`.

The package does not redistribute the competition data.

## 3. Quick evaluation from the final checkpoint

```bash
bash scripts/render_submission.sh \
  checkpoints/gaussians/final.pt \
  "$(sed -n '5p' 'data/Contest Dataset/camera_parameters/images.txt')" \
  outputs/example
```

This writes:

```text
outputs/example/rgb.png       # uint8 RGB image
outputs/example/semantic.png  # uint8 class IDs 0–4
```

## 4. Reproducing the reported results

The reported Task B results are reproduced from the bundled canonical checkpoint and the
submitted dataset artifacts:

```bash
bash scripts/setup.sh
bash scripts/evaluate_local.sh
```

This evaluates the same 30 held-out views used for the paper. The expected metrics and artifact
checksums are recorded in [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md).

## 5. Optional retraining

The submitted `outputs/gt_masks/` and `outputs/pseudo_masks/` are the canonical supervision
artifacts used for the reported Task B run. To retrain Task B against those same masks:

```bash
bash scripts/train_task_b.sh
```

Task A can be retrained and inspected separately:

```bash
bash scripts/prepare_masks.sh
bash scripts/train_task_a.sh
bash scripts/generate_pseudo_masks.sh \
  outputs/checkpoints/segformer_mitb0/best.pt \
  outputs/pseudo_masks_regenerated
```

Running `bash scripts/generate_pseudo_masks.sh` with no arguments uses the bundled Task A
checkpoint and writes to `outputs/pseudo_masks_regenerated/`, leaving the canonical submitted
pseudo-masks unchanged. Optional retraining may vary numerically across hardware and software
builds; exact reproduction of the submitted result is therefore based on the supplied checkpoints
and checksums rather than bitwise-identical retraining.

The canonical configuration uses an 80/10/10 labeled split, 80 Task A epochs, and 40,000
full-resolution Task B iterations with Task B seed 42. `configs/submission.yaml` is a
human-readable record of these settings; the executable shell scripts pass them explicitly.
See also [`REPRODUCIBILITY.md`](REPRODUCIBILITY.md).

## 6. Main implementation

```text
src/colmap_io/             camera parsing, test-excluded triangulation, color sampling,
                           and semantic voting
src/segmentation/          SegFormer training and pseudo-mask inference
src/gaussian_splatting/    undistortion, model, losses, training, RGB/semantic rendering
src/evaluation/            split utilities and render-based metrics
src/utils/json_to_mask.py  Labelme polygons to official class-ID masks
```

For the organizers' blind test, use `python -m src.gaussian_splatting.render` with either one
COLMAP `images.txt` pose line or explicit quaternion and translation values. Run `--help` for
the complete interface.
