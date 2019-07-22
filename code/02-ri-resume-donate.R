## RI Hypothesis Tests
## Ryan T. Moore
## First: 6 July 2017
## Last: 29 January 2019


# Preliminaries -----------------------------------------------------------

library(tidyverse)


# RI for Resume Experiment ------------------------------------------------

resume <- read.csv("https://raw.githubusercontent.com/kosukeimai/qss/master/CAUSALITY/resume.csv")

head(resume)

table(resume$race, resume$call)

# Calculate obs TE:
resume %>% group_by(race) %>% summarise(callback_rate = mean(call))

# Calculate obs TE:
obs_te <- mean(resume$call[resume$race == "black"]) - 
  mean(resume$call[resume$race == "white"])

# How many ways to split 4870 in half?
choose(4870, 4870 / 2)

# ... Better sample from the randomization distribution, then.

# Core idea:
tc <- rep(0:1, 5)
sample(tc)
sample(tc)
# Calculate and store est ATE for each assignment

# Implementation:
n_samples <- 10000
df <- data.frame(est_te = rep(NA, n_samples))
base_assignment <- rep(0:1, 4870/2)

for(idx in 1:n_samples){
  this_assignment <- sample(base_assignment)
  this_mean_tr <- mean(resume$call[this_assignment == 1])
  this_mean_co <- mean(resume$call[this_assignment == 0])
  df$est_te[idx] <- this_mean_tr - this_mean_co
}

# Results

summary(df)
ri_hist <- ggplot(df, aes(est_te)) + geom_histogram(stat = "count") + 
  labs(x = "Estimated Effect of Black Name on CV")

# pdf("figs/riHist_resume1.pdf")
ri_hist
# dev.off()

# pdf("figs/riHist_resume2.pdf")
ri_hist + geom_vline(xintercept = obs_te, color = "red") + 
  annotate("text", x = -.028, y = 300, label = "Observed!", color = "red", angle = 15)
# dev.off()

p_value <- mean(abs(df$est_te) >= abs(obs_te))
p_value

t.test(call ~ race, data = resume)




# RI for Gerber Green Donations Example -----------------------------------

# Prep data
donate <- data.frame(tr = rep(1:0, each = 10),
                     donation = c(500, 100, 100, 50, 25, 25, 0, 0, 0, 0, 25, 20, 15, 15, 10, 5, 5, 5, 0, 0))

# Calculate observed difference in means
obs_te <- mean(donate$donation[donate$tr == 1]) - mean(donate$donation[donate$tr == 0])

# (Alternate implementation)
donation_by_assg <- donate %>% group_by(tr) %>% summarise(avg_donation = mean(donation))
donation_by_assg
obs_te <- donation_by_assg$avg_donation[2] - donation_by_assg$avg_donation[1]
obs_te

# Implement RI

n_samples <- 10000
df_est_te <- data.frame(est_te = rep(NA, n_samples))
base_assignment <- rep(0:1, nrow(donate)/2)

for(idx in 1:n_samples){
  this_assignment <- sample(base_assignment)
  this_mean_tr <- mean(donate$donation[this_assignment == 1])
  this_mean_co <- mean(donate$donation[this_assignment == 0])
  df_est_te$est_te[idx] <- this_mean_tr - this_mean_co
}

# Results

summary(df_est_te)
ri_hist <- ggplot(df_est_te, aes(est_te)) + geom_histogram(stat = "count") + 
  labs(x = "Estimated Effect of Mailer on Donation")

# pdf("figs/riHist_donate1.pdf")
ri_hist
# dev.off()

# pdf("figs/riHist_donate2.pdf")
ri_hist + geom_vline(xintercept = obs_te, color = "red") + 
  annotate("text", x = 62, y = 140, label = "Observed!", color = "red", angle = 15)
# dev.off()

p_value <- mean(df_est_te$est_te >= obs_te)
p_value

t.test(donation ~ tr, data = donate, alternative = "less")




# The RI Confidence Interval ----------------------------------------------

ri_ci <- function(tau = 0, n_samples = 1000){
  
  df_tau_pval <- data.frame(tau = rep(NA, length(tau)),
                            pval = rep(NA, length(tau)))
  
  for(tau_idx in 1:length(tau)){
  
  donate$donation_tr <- donate$donation
  donate$donation_tr[donate$tr == 0] <- donate$donation[donate$tr == 0] + tau[tau_idx]
  
  donate$donation_co <- donate$donation
  donate$donation_co[donate$tr == 1] <- donate$donation[donate$tr == 1] - tau[tau_idx]
  
  df <- data.frame(est_te = rep(NA, n_samples))
  base_assignment <- rep(0:1, nrow(donate)/2)
  
  for(idx in 1:n_samples){
    this_assignment <- sample(base_assignment)
    this_mean_tr <- mean(donate$donation_tr[this_assignment == 1])
    this_mean_co <- mean(donate$donation_co[this_assignment == 0])
    df$est_te[idx] <- this_mean_tr - this_mean_co
  }
  
  p_value <- mean(abs(df$est_te - tau[tau_idx]) >= abs(obs_te - tau[tau_idx]))
  
  df_tau_pval[tau_idx, ] <- c(tau[tau_idx], p_value)
  }
  
  return(df_tau_pval)
}

df_taus <- ri_ci(-130:270)
  
# Keep only those tau s.t. p > \alpha:
df_taus %>% filter(pval > 0.05) %>% 
  summarise(lb = min(tau), ub = max(tau)) 



%>% ggplot() + 
  geom_segment(aes(x = lb, xend = ub, y = 0, yend = 0)) + 
  geom_point(x = obs_te, y = 0) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) + 
  labs(x = "Possible Values of ATE")
