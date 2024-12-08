# AudioImageTextML-R

This repository contains the final project for a Machine Learning course, focusing on processing and analyzing data from three different modalities: audio, images, and text. Each modality is handled using specialized libraries and techniques.

## Features

### **Audio Processing**
- Analyze metadata of audio files (duration, sampling rate, channels, etc.).
- Plot waveforms and zoom into specific segments.
- Generate periodograms and spectrograms.
- Apply filters (low-pass and high-pass) to audio signals.
- Use R libraries: `tuneR`, `seewave`.

### **Image Processing**
- Perform PCA (Principal Component Analysis) on image color channels to reconstruct and compress images.
- Visualize original and reconstructed images with a varying number of principal components.
- Save and compare sizes of original and compressed images.
- Use R library: `imager`.

### **Text Processing**
- Clean text data by removing punctuation, numbers, extra whitespace, and stopwords.
- Generate term-document matrices (bag-of-words representation).
- Calculate word frequencies and identify the most frequent words.
- Visualize word frequency distributions using word clouds.
- Use R libraries: `tm`, `wordcloud`.

## Project Structure

AudioImageTextML-R/
├── Audio/
│   ├── R scripts for audio analysis
│   ├── Sample audio files (e.g., "baby_background.wav", "piano.wav")
├── Image/
│   ├── R scripts for image processing
│   ├── Sample image files (e.g., "dukes.jpeg")
├── Text/
│   ├── R scripts for text processing
│   ├── Sample text files (e.g., "i_have_a_dream.txt")
├── README.md

## Getting Started

### Prerequisites
- R programming environment
- Required R libraries:
  - **Audio**: `tuneR`, `seewave`
  - **Image**: `imager`
  - **Text**: `tm`, `wordcloud`

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/MatiasLoiseau/AudioImageTextML-R.git
   ```
2. Navigate to the desired modality directory (`Audio/`, `Image/`, or `Text/`).
3. Ensure all required libraries are installed in R.

### Running the Code
Each directory contains R scripts tailored to the respective modality. Example steps:
1. **Audio**: Analyze audio files using scripts in the `Audio/` directory.
   ```R
   source("audio.R")
   ```
2. **Image**: Apply PCA to compress images using scripts in the `Image/` directory.
   ```R
   source("image.R")
   ```
3. **Text**: Process text and generate word clouds using scripts in the `Text/` directory.
   ```R
   source("text.R")
   ```

---

## Example Outputs

### Audio
- Waveforms and zoomed segments.
- Periodograms and spectrograms.
- Filtered audio with low-pass and high-pass frequency cutoffs.

### Image
- Reconstructed images with different numbers of principal components.
- Comparison of original and compressed image sizes.

### Text
- Word cloud visualizations.
- Most frequent word identification.
- Bag-of-words representation with term-document matrices.