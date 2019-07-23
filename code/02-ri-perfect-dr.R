
# Intro to R Packages -----------------------------------------------------


# Only needed once:
# install.packages(blockTools) 
library(blockTools)

# Intro to R Data ---------------------------------------------------------

# Vectors:
# Create with c(), 1:5, rep(), etc.
x <- 3:10

# Extract elements with []
x[1]

# Data frames

df <- data.frame(x = 3:10, 
                 y = sample(0:1, size = 8, replace = TRUE))

df

df[1, 2]

df$x

df$y[3]

df$x[df$y == 0]

# Some packages come with data:

# From blockTools:
data(x100)

# From fivethirtyeight.com stories
library(fivethirtyeight)
help(package = "fivethirtyeight")
data("cand_events_20150114")

head(cand_events_20150114)

data("trump_twitter")
dim(trump_twitter)
head(trump_twitter)

data("steak_survey")
head(steak_survey)
table(steak_survey$steak_prep)


# Some data are on the web:

resume <- read_csv("http://j.mp/2sDjsHI")


# Intro to for loops ------------------------------------------------------

# i is a variable:

for(i in 1:10){
  print(i)
}

for(i in x){
  print(i)
}

# Clean up
ls()

rm(list = ls())

# RI for the Perfect Doctor -----------------------------------------------

# Create y1, y0 under the sharp null:
y1 <- c(6, 12, 9, 11)
y0 <- c(6, 12, 9, 11)

# Create treatment vector
t <- c(1, 1, 0, 0)

# Calculate obs difference in means, given t:
mean(y1[t == 1]) - mean(y0[t == 0])

# Calculate difference in means, given new t:
t <- c(1, 0, 1, 0)
mean(y1[t == 1]) - mean(y0[t == 0])

# Create a function that takes t, calculates and returns diff-in-means:
est_te <- function(t){
  
  dm <- mean(y1[t == 1]) - mean(y0[t == 0])
  
  return(dm)
}


est_te(t)

est_te(t = c(1, 0, 0, 1))
est_te(t = c(0, 1, 1, 0))
est_te(t = c(0, 1, 0, 1))
est_te(t = c(0, 0, 1, 1))

library(gtools)
# Create all possible assignments:
rand_mat <- permutations(n = 2, r = 4, v = 0:1, repeats.allowed = TRUE)

## Figure out which have 2 treated, 2 control:
rowSums(rand_mat) == 2

## Keep only those:

rand_mat <- rand_mat[rowSums(rand_mat) == 2, ]

diffs_means <- rep(NA, nrow(rand_mat))
  
for(i in 1:nrow(rand_mat)){
  
  dm <- mean(y1[rand_mat[i, ] == 1]) - mean(y0[rand_mat[i, ] == 0])
  
  diffs_means[i] <- dm
  
}

abs(diffs_means) >= abs(-1)


# Best:

ri_pvalue <- function(y1, y0, rand_mat, obs_tr){
  
  diffs_means <- rep(NA, nrow(rand_mat))
  
  obs_te <- mean(y1[obs_tr == 1]) - mean(y0[obs_tr == 0])
  
  for(i in 1:nrow(rand_mat)){
    
    dm <- mean(y1[rand_mat[i, ] == 1]) - mean(y0[rand_mat[i, ] == 0])
    
    diffs_means[i] <- dm
    
  }
  
  print(diffs_means)
  pvalue <- mean(abs(diffs_means) >= abs(obs_te))
  
  return(pvalue)
  
}

ri_pvalue(y1 = y1, y0 = y0, rand_mat = rand_mat, obs_tr = c(1, 1, 0, 0))
