# setwd('path/to/working-directory')

library(rgl)
library(jpeg)
image <- readJPEG('imagens/maverick.jpg')
plot(image)
bands <- data.frame(red = as.vector(image[,,1]),
                    green = as.vector(image[,,2]),
                    blue = as.vector(image[,,3]))

attach(bands)
var(bands)

cor(bands)

plot3d(bands, col=rgb(red,green,blue), pch=20)
# snapshot3d("")

pca_image <- prcomp(bands, scale = TRUE, center = TRUE)

summary(pca_image)

(rotMatrix <- pca_image$rotation)

rotMatrix %*% t(rotMatrix)

bands_pc <- data.frame(PC1 = pca_image$x[,1],
                       PC2 = pca_image$x[,2],
                       PC3 = pca_image$x[,3])

png(filename="imagens/boxplot-pca.png")
boxplot(c(bands, bands_pc), horizontal = TRUE, notch = TRUE,
        main = "Variâncias X Bandas RGB e PCA",
        xlab="Variância", ylab="Bandas")
dev.off()
