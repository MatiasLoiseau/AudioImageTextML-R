setwd("~/workspace/AudioImageTextML-R/Image")
library(imager)

# Load the image
image <- load.image("dukes.jpeg")

# The image has dimensions: width, height, z (depth, usually 1), color channel (3 for RGB)
print(dim(image)) 
# 1200  800    1    3
# This means: width=1200, height=800, z=1, channels=3

# Extract the three color channels: R, G, B
R <- image[,,1,1]
G <- image[,,1,2]
B <- image[,,1,3]

# Convert each channel to a matrix. They already are, but ensure the type:
R <- as.matrix(R)
G <- as.matrix(G)
B <- as.matrix(B)

# Dimensions of each channel: 1200 x 800 (width x height)
# Decide whether to perform PCA by rows or by columns. 
# Rows will be used as "observations" and columns as "variables".
# Thus, prcomp will apply PCA to a matrix with dimensions (rows=width, columns=height).

# Helper function to apply PCA to a channel and reconstruct the image with a given number of components k
reconstruct_channel <- function(channel_matrix, k) {
  # Apply PCA.
  # center=TRUE: center the data
  # scale.=FALSE: no scaling since the image is already in [0,1] or [0,255] (depending on the format).
  pca <- prcomp(channel_matrix, center=TRUE, scale.=FALSE)
  
  # Get the k principal components
  # pca$x are the coordinates of the observations in the principal components space (dim: n_rows x n_columns)
  # pca$rotation are the eigenvectors (loadings matrix)
  # Reconstruction with k components: X_approx = X_centered + PC_k * t(Rotation_k)
  
  # X_centered = channel_matrix - pca$center (properly expanded)
  # But prcomp stores the mean in pca$center (vector of length = number of columns)
  
  # Reconstruct:
  X_centered_approx <- pca$x[,1:k] %*% t(pca$rotation[,1:k])
  
  # Add the mean back
  # pca$center is a vector with length equal to the number of columns in channel_matrix
  # Add this mean to each row of X_centered_approx
  X_approx <- sweep(X_centered_approx, 2, pca$center, '+')
  
  return(X_approx)
}

# Define the number of principal components to use
k1 <- 20
k2 <- 100

# Reconstruct the image using k1 components
R_k1 <- reconstruct_channel(R, k1)
G_k1 <- reconstruct_channel(G, k1)
B_k1 <- reconstruct_channel(B, k1)

# Reconstruct the image using k2 components
R_k2 <- reconstruct_channel(R, k2)
G_k2 <- reconstruct_channel(G, k2)
B_k2 <- reconstruct_channel(B, k2)

# Create images in cimg format from the reconstructed matrices
# The function as.cimg expects a vector in the order x,y,z,cc. Here z=1, cc=3.
# The matrices R,G,B have dimensions (width x height). imager uses: x along the first dimension, y along the second.
# Our matrices R,G,B are (width x height), corresponding to (x,y).

image_k1 <- as.cimg(array(c(R_k1, G_k1, B_k1), dim = c(dim(R_k1)[1], dim(R_k1)[2], 1, 3)))
image_k2 <- as.cimg(array(c(R_k2, G_k2, B_k2), dim = c(dim(R_k2)[1], dim(R_k2)[2], 1, 3)))

# Display the original image and the reconstructed ones
par(mfrow=c(1,3))
plot(image, main="Original")
plot(image_k1, main=paste("Reconstructed with", k1, "PC"))
plot(image_k2, main=paste("Reconstructed with", k2, "PC"))

# Save the new images
save.image(image_k1, "dukes_recon_k20.jpg", quality = 0.9)
save.image(image_k2, "dukes_recon_k100.jpg", quality = 0.9)

# Display the size of the original and reconstructed images
original_size <- file.info("dukes.jpeg")$size
k1_size <- file.info("dukes_recon_k20.jpg")$size
k2_size <- file.info("dukes_recon_k100.jpg")$size

cat("Original size:", original_size, "bytes\n")
cat("Reconstructed size k=", k1, ":", k1_size, "bytes (", round((k1_size/original_size)*100,2), "% of the original)\n")
cat("Reconstructed size k=", k2, ":", k2_size, "bytes (", round((k2_size/original_size)*100,2), "% of the original)\n")
