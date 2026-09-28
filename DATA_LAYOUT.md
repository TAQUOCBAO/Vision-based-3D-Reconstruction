# Dataset layout

Set `CONTEST_DATASET_DIR` to the organizer-provided dataset directory, or place the data at the
default path below:

```text
data/Contest Dataset/
├── images/                 300 labeled RGB images
├── unlabeled_Images/       100 RGB-only images
├── json/                   Labelme polygon annotations
└── camera_parameters/
    ├── cameras.txt
    ├── images.txt
    └── points3D.txt        may be absent; this implementation triangulates points from tracks
```

Generated files are written under `outputs/`:

```text
outputs/
├── gt_masks/
├── pseudo_masks/
├── undistorted_images/
├── undistorted_gt_masks/
├── undistorted_pseudo_masks/
├── checkpoints/
│   ├── segformer_mitb0/
│   └── gaussians/
└── eval/
```

Do not rename the organizer's image files because the split and COLMAP observations use those
names to associate images, poses, tracks, and masks.

