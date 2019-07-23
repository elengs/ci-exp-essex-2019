# #
# # ---------------------------
# #
# # Script name: Tengs_P1
# #
# # Purpose of script: Assignment P1
# #
# # Author: Elise Tengs (elise.tengs@gu.se)
# #
# # Date Created: 23.07.2019
# #
# # ---------------------------


# Exercise 2.1 
# ---------------------------
#   
#   Potential outcomes notation: 
#   
#   Y: outcome
# i: individual, where i=...n
# T: treatment, where T is binary and takes the value 1 if the individual has been exposed to treatment, and 0 if the individual has not been exposed to treatment. 
# D: "dosage", indicates whether or not the individual has received the treatment or not, i.e. if the individual is a member of the control group (D=0) or the treatment group (D=1). 
# d: Observable treatment
# 
# a) The notation "Y_i(0)" gives the outcome for an individual i if not exposed to treatment, i.e. T_i=0. 
# b) The notation "Y_i(0)|D_i=1" gives the outcome Y for an individual i when not exposed to treatment, when the individual is in the treatment group 
# (i.e. unobserved outcome). The notation "Y_i(0)|d_i=1" indicates the same as above, but with the observable (actual treatment).
# c) The notation "Y_1(0)" gives the potential outcome with no treatment, whereas "Y_i(0) | D_i=0" gives the outcome for the individuals in the control group, when not exposed to treatment. 
# d) The notation "Y_i(0)|D_i = 0" indicates the outcome when not treated for an individual in the control group, whereas the notation "Y_i(0)|D_i=1" indicates the outcome when no treatmen, 
# for the individuals in the treatment group. Thus, the latter is unobservable. 
# e) The notation "E[Y_i(0)" indicates the expected outcome for individual i with no treatment. The notation "E[Y_i(0)|D_i=1" is the 
# expected hypothetical outcome for an individual with no treatment, for a member of the treatment group. It is an hypothetical situation: 
#   What would be the outcome for an individual who receives treatment, if this individual had not received treatment.  
# f) Under (perfect) random assignment of the treatment, there is no selection bias. Selection bias occurs if the potential outcome gives information 
# about whether or not the individual has received treatment. 
# 
# Exercise 2.10
# ---------------------------
#   
#   a) According to the excludability assumption, only the treatment d has an effect on the outcome Y_i, 
# and there can be no effect of the assignment mechanism z on the outcome. Thus, the fact that a student is informed by the treatment, 
# and even the potential outcome of this treatment on the student's own behaviour, violates this assumption.
# Assuming that Y_i(d,z) is the outcome for individual i, and that d and z are binary. 
# d takes the value 1 if the individual receives treatment, and 0 if this is not the case. z takes the value 1 if the individual 
# is assigned to the treatment group, and 0 if the individual is assigned to the control group. 
# According to the excludability assumption, only the treatment d has an effect on the outcome, thus: Y_i(1,d) = Y_i(0,d). 
# However, when the student receives information about the assignment to a treatment group, this is no longer the case as the potential outcome 
# might differ depending on whether z=1 or z=0. 
# 
# b) According to the assumption of non interference - also referred to as the Stable Unit Treatment Value Assumption - the outcome for an individual i 
# is independent of the whether or not other individuals receive the treatment. I.e. there can be no spillover effects; 
# the treatment to an individual i cannot influence the outcome for another individual. 
# If the students bring the newspapers they receive to the cafeteria, there are numerous ways in which this assumption does not hold. 
# E.g. the newspaper might be read by other participants in the experiment, 
# and regardless of whether they are assigned to the treatment or the control group, this might influence their outcome. 
# This means that when writing Y_i(d), this outcome can only be determined by the treatment d assigned to that specific individual. 
# 
# Exercise 2.12
# ---------------------------
# Treatment d: 3+ hours of dayly reading of newspapers. d takes the value 1 when the prisoner reads more than 3h, and 0 if the prisoner reads less.
# Y_i(0) indicates the potential outcome when the prisoner reads less than 3h, and Y_i(1) indicates the potential outcome when the prisoner reads more
# (i.e. receives the treatment). 
# a) The treatment will not be random if it is up to the prisoners themselves to determine how much they read. There might be a correlation between those
# who chose to read more, and who are less violent. I.e. one might think that less violent prisoners also will be inclined to choose to read more.
# Thus, the expected outcome for an individual who 
# b) The excludability assumption might not hold in this experiment. It is possible that the participants in the control group, albeit
# being randomly chosen, happen to be among the most violent ones, or the ones initiating most violence. Thus, violence might be reduced
# during this week, not because of the reading, but because prisoners spend less time together. I.e. the outcome is a "co-product" (Gerber and Green, 2012, p. 45) 
# of the assignment.  
# c) The non-interference assumption might not hold in this experiment. It might be that prisoners in the treatment group will talk about 
# literature with the other prisoners, and thus influence their outcome. 
# d) When aiming to evaluate the effect of a policy where all prisoners are required to read for three ours every day, the details of the prison must also be 
# taken into account: How much communication is there between the prisoners? Are they allowed to have long conversation without any supervision? If yes, 
# there might be spillover effects of the treatment. It is also important to consider how much the prisoners know about the activities of
# the other prisoners, as it might be that just knowing that other prisoners devote much of their time to reading will also influence the outcom. 
# In sum; it might be that - in order to reduce violence in prison - it might be enough to e.g. make some prisoners read, or separate the 
# prisoners more (allowing for more individual time), depending on the exact prison. 
