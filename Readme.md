# 3D Point Cloud Reconstruction

![Gif I am gonna insert]

## Project Overview
This project was part of the course **Nuages de points et Modélisation 3D** at MinesParis. It was conducted by **Alexandros Kouvatseas** and **Luka Lafaye de Micheaux**.

Our work is based on the paper: [CT-ICP: Real-time Elastic LiDAR Odometry with Loop Closure](https://arxiv.org/abs/2109.12979).

We used the **KITTI Raw Dataset** for our experiments due to storage constraints.

## Dataset: KITTI Raw
The **KITTI Dataset** is a widely used benchmark in autonomous driving research, providing high-quality data for tasks such as odometry, object detection, and scene understanding. It includes multiple sub-datasets:
- **KITTI Corrected**: LiDAR scans with motion correction based on IMU/GPS data.
- **KITTI 360**: Extended sequences with more scans and a broader coverage area.
- **KITTI Raw**: Unprocessed LiDAR scans without motion correction, requiring additional preprocessing for accurate mapping.

We specifically used **KITTI Raw** because of storage limitations while still maintaining the necessary data quality for our experiments.

## Challenges Faced
During the project, we encountered several challenges, including:
- **Issues Running on KITTI**: The CT-ICP implementation had several challenges when applied to KITTI, including dataset compatibility and configuration issues.
- **3D Reconstruction**: Applying the algorithm to full 3D reconstruction posed difficulties in terms of processing large-scale point clouds effectively.
- **Superbuild Failures**: Several compilation errors arose due to dependencies and system incompatibilities, particularly when building on different versions of Linux.
- **Missing Dependencies**: The installation process required additional dependencies like `git-lfs`, which were not clearly documented and led to runtime errors.
- **CMake Build Failures**: The installation process often failed due to mismatched build configurations and missing system libraries.
- **ROS Integration Issues**: Running CT-ICP with ROS and integrating it into existing SLAM pipelines presented issues related to package compatibility and launch file configuration.
- **Saving Maps and Point Clouds**: There were difficulties in exporting and saving generated point clouds and maps for further processing.
