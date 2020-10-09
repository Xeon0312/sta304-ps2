# ----------------------------------------------------
# Data simulation for Problem Set 2                   |
# STA304 - Fall 2020                                  |
# Authors: Boyu Cao, Jiayi Yu, Yijia Liu, Ziyue Yang  |
# ----------------------------------------------------

# Setting seed as the last 4 digits of Ziyue Yang's student number, for reproducibility
set.seed(4759)
library(tidyverse)


# We begin with storing choices in vectors
# which will be used for sampling in the next chunk
# For section 'citizenship'
citizenship <- c("Canadian Citizen", "Permanent Resident", "Other")
# For section 'Personal Background'
# On what basis do you assess a political candidate?
basis <- c("News on TV", "Articles in the newspaper", "Attend events where the candidate is addressing the people", "I research all the all the channels before making my choice", "Number of fundraisers the candidate has done in you area", "The family upbringing of the candidate", "Other")
# What decade were you born in? 
decade <- c('1940-1949', '1950-1969', '1970-1989', '1990-2004')
# How do you identify yourself?
gender <- c("Female", "Male", "Prefer not to say")
# Does your household income fall into one of these broad ranges?
income <- c("0", "$1-$50,000", "$50,000-$100,000", "$100,000-$150,000", "$150,000-$200,000", "More then $200,000", "Prefer not to say")
# What is the highest level education that you have completed?
education <- c("No schooling", "Completed elementary school", "Completed high school", "Completed technical, community College, CEGEP, collage Classique", "Bachelor's degree", "Master's degree", "Professional degree or doctorate", "Prefer not to say")
# What is your employment status?
employment <- c("Working for pay full-time", "Working for pay part-time", "Self-employed", "Unemployed/looking for work", "Student", "Other")
# If you could vote in this election, which party do you think you will vote for?
# We use the vector 'party' below
# party_noncitizen <- c("Liberal", "Conservative", "NDP", "Green", "Other")
# ADD NONCITIZEN?
# ---
# Section Political Leanings, citizen
party <- c("Liberal", "Conservative", "NDP", "Green", "Other")
# Which party did you vote in last election?
last_vote <- c("Liberal", "Conservative", "NDP", "Green", "Other")
# Do you think the existing government is going in the right direction to benefit the people of the country?
right_dir <- c("Yes", "No", "Maybe")
# How likely are you gonna vote in the upcoming
likely_vote <- c(1:10)
# Which party are you gonna vote?
will_vote <- c("Liberal", "Conservative", "NDP", "Green", "Don't know")
# What’s the most important problem facing Canada today?
problem <- c("Economy generally", "Unemployment", "Healthcare", "Crime", "Immigration", "Environmental Issue", "Other")
# ---
# Choices for section 'Policy'
# What issue do you focus more on?
focus_issue <- c("Economy", "Employment", "Public Health", "Prime and Justice", "Immigration Policy", "Tax Policy", "")
# Do you agree with one or more of the following? Select all that apply.
agree_statements <- c("There should be policies to resolve the gap between the rich and the poor.", "Environment safety is more important than business tax revenue.", "There should be rules to include all religions in all political parties.", "The government should assist corporations in increasing employment.", "The government should pay more on public health programs.", "There should be more free trade with other countries, even if it hurts some industries in Canada.")
# Simulating data using the sample function
# setting sample size
n <- 500
# Simulating n samples answers to section 'Personal Background'
background <- tibble(basis = sample(x = basis, size=n, replace=TRUE), 
                     citizenship = sample(x=citizenship, size=n, replace=TRUE, prob = c(0.8, 0.1, 0.1)),
                     decade_born = sample(x=decade, size=n, replace=TRUE),
                     education_level = sample(x=education, size=n, replace=TRUE), # [Education]
                     gender = sample(x=gender, size=n, replace=TRUE, prob = c(0.4915, 0.4915, 0.017))#there exists 1.7% population identified them 'Non-binary' in Canada [NonBin].
                     , employment_status = sample(x=employment, size=n, replace=TRUE))

# [Education] Reference https://www12.statcan.gc.ca/census-recensement/2016/dp-pd/hlt-fst/edu-sco/Table.cfm?Lang=E&T=11&Geo=00&SP=1&view=2&age=2&sex=1
# [NonBin] https://www.statcan.gc.ca/eng/dai/smr08/2015/smr08_203_2015
# Simulating n samples answering section 'Political Leanings'
political_leaning <- tibble(last_vote = sample(x=last_vote, size=n, replace=TRUE, prob=c(0.1965, 0.4136, 0.3429, 0.0047, 0)),
                            likely_vote = sample(x=likely_vote, size=n, replace=TRUE),
                            problem_focused = sample(x=problem, size=n, replace=TRUE, prob = c(0.1,0.05,0.05,0.3,0.1,0.125,0.125)),
                            right_direction = sample(x=right_dir, size=n, replace=TRUE, prob = c(0.3, 0.6, 0.1)),
                            will_vote = sample(x=party, size=n, replace=TRUE, prob = c(0.5, 0.3, 0.15, 0.025, 0.025)),
)

# Combining sections' Answers
election_data <- bind_cols(background, political_leaning) %>% filter(citizenship=="Canadian Citizen")


# We use ggplot to generate the following figures
# Most of the following figures are now shown in report.Rmd
# They are for our own references when analyzing results

# Plotting the distribution of which parties were voted in the last election
last_vote_figure <- ggplot(election_data, aes(x=last_vote)) + geom_bar() + labs(title="Distribution of Parties Voted Previously", caption = "Figure 1. Distribution of which parties the samples voted in the previous election.") + xlab("Party Voted") + guides(fill=guide_legend(title="Problem Concerned"))

# Answer distribution to question "Do you think the existing gov' is bringing benefits to country? "
benefit_plot <- ggplot(election_data, aes(x=right_direction)) + geom_bar()

# Distribution of which parties to vote for in the next election.
next_vote_plot <- ggplot(election_data, aes(x=will_vote)) + geom_bar()

# Distribution of which parties to vote for in the next election; colors indicates whether the voter agrees that 
# the current party is bringing benefits to the country.
next_vote_benefit_fill <- ggplot(election_data, aes(x=will_vote, fill=right_direction)) + geom_bar()

age_dist_problem_fill <- ggplot(election_data, aes(y=decade_born, fill=problem_focused), labs(title="Distribution of Problems Concerned", subtitle="Grouped by Decade Born")) + geom_bar() + ylab("Decade Born") + guides(fill=guide_legend(title="Problem Concerned"))

employment_dist_dir_fill <- ggplot(election_data, aes(y=employment_status, fill = problem_focused)) + geom_bar()
