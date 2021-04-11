#... PCA Analysis ----

# https://www.datacamp.com/community/tutorials/pca-analysis-r

#... Trying with mtcars first

# Works best with numeric variables so excluding categorical variables

mtcars.pca <- prcomp(mtcars[,c(1:7,10,11)], center = TRUE, scale. = TRUE)

summary(mtcars.pca)

pacman::p_load(
  devtools)

install_github("vqv/ggbiplot")
library(ggbiplot)

ggbiplot(mtcars.pca)

# Can add labels with labels option; groups with groups option and ellipses
# Use choices to pick other than first two PCs
