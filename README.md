# AudioImageTextML-R

This repository contains the final project for a Machine Learning course, focusing on three different data modalities: audio, images, and text.

## Features
- **Audio Processing**
- **Image Processing**
- **Text Processing**

## Prerequisites

- **R (>= 4.4)**
- Required system libraries for R packages:
  - `libtiff-dev`
  - `libjpeg-dev`
  - `libpng-dev`
  - `libmagick++-dev`
  - `sox` (for audio processing)

To install R on Ubuntu 24.10:

```bash
sudo apt update
sudo apt install -y r-base
```

### Installing System Libraries

Run the following commands to install the necessary libraries on Ubuntu 24.10:

```bash
sudo apt update
sudo apt install -y libtiff-dev libjpeg-dev libpng-dev libmagick++-dev sox
```

## Installing R Packages

After installing the prerequisites, install the required R packages by running the following commands inside R:

```R
# audio
install.packages("tuneR")
install.packages("seewave")

# image
install.packages("imager")
install.packages("magick")
```