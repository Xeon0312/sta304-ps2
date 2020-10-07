# Script to simulate data; identical to the one in Rmd

# Setting seed as the last 4 digits of my student number
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
decade <- c('1930-1949', '1950-1969', '1970-1989', '1990-2010')

# How do you identify yourself?
gender <- c("Female", "Male", "Prefer not to say")

# Does your household income fall into one of these broad ranges?
income <- c("0", "$1-$50,000", "$50,000-$100,000", "$100,000-$150,000", "$150,000-$200,000", "More then $200,000", "Prefer not to say")

# What is the highest level education that you have completed?
education <- c("No schooling", "Completed elementary school", "Completed high school", "Completed technical, community College, CEGEP, collage Classique", "Bachelor's degree", "Master's degree", "Professional degree or doctorate", "Prefer not to say")

# What is your employment status?
employment <- c("Working for pay full-time", "Working for pay part-time", "Self-employed", "Unemployed/looking for work", "Student", "Other")



# For non-citizens

# If you could vote in this election, which party do you think you will vote for?
# We use the vector 'party' below
# party_noncitizen <- c("Liberal", "NDP", "Conserv", "Green", "Other")

# ----------------

# For citizens
# Section Political Leanings, citizen
party <- c("Liberal", "NDP", "Conserv", "Green", "Other")

# Which party did you vote in last election?
last_vote <- c("Liberal", "NDP", "Conserv", "Green", "Other")

# Do you think the existing government is going in the right direction to benefit the people of the country?
right_dir <- c("Yes", "No", "Maybe")

# How likely are you gonna vote in the upcoming
likely_vote <- c(1:10)

# Which party are you gonna vote?
will_vote <- c("Liberal", "NDP", "Conserv", "Green", "Don't know")

# What’s the most important problem facing Canada today?
problem <- c("Economy generally", "Unemployment", "Healthcare", "Crime", "Immigration", "Environmental Issue", "Other")

# Choices for section 'Policy'

# What issue do you focus more on?
focus_issue <- c("Economy", "Employment", "Public Health", "Prime and Justice", "Immigration Policy", "Tax Policy", "")

# Do you agree with one or more of the following? Select all that apply.
agree_statements <- c("There should be policies to resolve the gap between the rich and the poor.", "Environment safety is more important than business tax revenue.", "There should be rules to include all religions in all political parties.", "The government should assist corporations in increasing employment.", "The government should pay more on public health programs.", "There should be more free trade with other countries, even if it hurts some industries in Canada.")


# Sample size
n <- 500

# Simulating n samples answering section 'Personal Background'
background <- tibble(basis = sample(x = basis, size=n, replace=TRUE), 
                     citizenship = sample(x=citizenship, size=n, replace=TRUE, prob = c(0.8, 0.1, 0.1)),
                     decade_born = sample(x=decade, size=n, replace=TRUE),
                     education_level = sample(x=education, size=n, replace=TRUE),
                     gender = sample(x=gender, size=n, replace=TRUE, prob = c(0.4915, 0.4915, 0.017))# based on the fact that there exists 1.7% of LGBTQ in Canada [1].
                     , employment_status <- sample(x=employment, size=n, replace=TRUE))

# Simulating n samples answering section 'Politial Leanings'
political_leaning <- tibble(last_vote = sample(x=last_vote, size=n, replace=TRUE, prob=c(0.24, 0.24, 0.24, 0.24, 0.04)),
                            likely_vote = sample(x=likely_vote, size=n, replace=TRUE),
                            # party_vote = sample(x=party, size=n, replace=TRUE),
                            problem_answer = sample(x=problem, size=n, replace=TRUE),
                            direction = sample(x=right_dir, size=n, replace=TRUE),
                            will_vote = sample(x=party, size=n, replace=TRUE),
)

# Combining Two Sections' Answers
election_data <- bind_cols(background, political_leaning)



