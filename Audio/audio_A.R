setwd("~/workspace/AudioImageTextML-R/Audio")

# https://www.kaggle.com/datasets/pavanelisetty/sample-audio-files-for-speech-recognition?resource=download
# https://www.kaggle.com/datasets/soumendraprasad/musical-instruments-sound-dataset
# https://www.kaggle.com/datasets/nafin59/hospital-ambient-noise

# Load necessary libraries
library(tuneR)
library(seewave)

# Function to analyze the metadata of audio files
analyze_metadata <- function(file) {
  sound <- readWave(file)
  metadata <- data.frame(
    File = file,
    Duration = length(sound@left) / sound@samp.rate,
    SamplingRate = sound@samp.rate,
    Channels = ifelse(sound@stereo, "Stereo", "Mono"),
    Samples = length(sound@left)
  )
  return(metadata)
}

# List of audio files
audio_files <- c("baby_background.wav", "piano.wav", "harvard.wav")

# Part A1: Analyze metadata
metadata_list <- lapply(audio_files, analyze_metadata)
metadata_table <- do.call(rbind, metadata_list)
print("Audio metadata:")
print(metadata_table)

# Part A2: Plot waveform of each audio file
plot_waveform <- function(file) {
  sound <- readWave(file)
  oscillo(sound)
  title(main = paste("Waveform of", file))
}

cat("\nGenerating waveforms...\n")
par(mfrow = c(1, 1))  # Ensure individual plots

for (file in audio_files) {
  plot_waveform(file)
}

# Part A3: Zoom in on waveforms
zoom_waveform <- function(file, start_time, duration) {
  sound <- readWave(file)
  samp_start <- as.integer(start_time * sound@samp.rate)
  samp_end <- as.integer((start_time + duration) * sound@samp.rate)
  zoomed_sound <- sound@left[samp_start:samp_end]
  time <- seq(start_time, start_time + duration, length.out = length(zoomed_sound)) / sound@samp.rate
  plot(time, zoomed_sound, type = "l", main = paste("Wave zoom in", file), xlab = "Time (s)", ylab = "Amplitude")
}

cat("\nGenerating waveform zooms...\n")
for (file in audio_files) {
  zoom_waveform(file, start_time = 1, duration = 0.005)  # Adjust time and duration as needed
}
