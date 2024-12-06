setwd("~/workspace/AudioImageTextML-R/Audio")

# Load the necessary libraries
library(tuneR)
library(seewave)

# Read the sound files
sound1 <- readWave("baby_background.wav")
sound2 <- readWave("piano.wav")
sound3 <- readWave("harvard.wav")

# Function to analyze a sound
analyze_sound <- function(sound, name) {
  cat("Analyzing:", name, "\n")
  
  # 1. Plot the periodogram
  cat("Plotting periodogram...\n")
  png(filename = paste0(name, "_periodogram.png"))
  par(mfrow = c(1, 1))
  spec(sound, main = paste("Periodogram of", name))
  axis(side = 2, las = 2)
  dev.off()
  
  # 2. Frequency range
  max_freq <- sound@samp.rate / 2
  cat("Frequency range: 0 to", max_freq, "Hz\n")
  
  # 3. Display the spectrogram
  cat("Displaying spectrogram...\n")
  flim_max <- min(10, max_freq / 1000) # Adjust flim to 10 kHz or the frequency range limit
  png(filename = paste0(name, "_spectrogram.png"))
  spectro(sound, flim = c(0, flim_max), main = paste("Spectrogram of", name))
  dev.off()
}

# Analyze each sound with the corrected code
analyze_sound(sound1, "baby_background")
analyze_sound(sound2, "piano")
analyze_sound(sound3, "harvard")

# 4. Low-pass and high-pass filters
filter_sound <- function(sound, name, cutoff_freq) {
  cat("Filtering", name, "with low-pass and high-pass filters...\n")
  
  # Low-pass filter
  soundLP <- ffilter(sound, to = cutoff_freq, output = "Wave")
  soundLP <- normalize(soundLP, unit = '16')
  png(filename = paste0(name, "_low_pass.png"))
  spectro(soundLP, flim = c(0, cutoff_freq / 1000), main = paste("Low-pass spectrogram of", name))
  dev.off()
  
  # High-pass filter
  soundHP <- ffilter(sound, from = cutoff_freq, output = "Wave")
  soundHP <- normalize(soundHP, unit = '16')
  png(filename = paste0(name, "_high_pass.png"))
  spectro(soundHP, flim = c(cutoff_freq / 1000, sound@samp.rate / 2000), main = paste("High-pass spectrogram of", name))
  dev.off()
}

# Apply filters to the first sound
cutoff_freq <- 5000 # Cutoff frequency in Hz
filter_sound(sound1, "baby_background", cutoff_freq)

# Apply filters to the second sound
cutoff_freq <- 2000 # Cutoff frequency in Hz
filter_sound(sound2, "piano", cutoff_freq)

# Apply filters to the third sound
cutoff_freq <- 1000 # Cutoff frequency in Hz
filter_sound(sound3, "harvard", cutoff_freq)
