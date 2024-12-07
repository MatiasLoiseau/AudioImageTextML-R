setwd("~/workspace/AudioImageTextML-R/Audio")

# Load the necessary libraries
library(tuneR)
library(seewave)

# Read the audio file
audio_file <- readWave("harvard-cut.wav")

# Display basic information about the audio file
print(audio_file)

# Normalize the audio
audio_file <- normalize(audio_file, unit = "16")

# Create the oscillogram
par(mfrow = c(1, 2))  # Split the graphical window into two parts
oscillo(audio_file, title = "Oscillogram of harvard-cut.wav")

# Create the spectrogram
spectro(audio_file, f = audio_file@samp.rate, wl = 512, ovlp = 50, 
        collevels = seq(-40, 0, by = 5), 
        main = "Spectrogram of harvard-cut.wav")