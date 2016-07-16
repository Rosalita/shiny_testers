setwd("/git/shiny_testers")

library(shiny) # load shiny

#Read data
mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")

# Make an index of all the people which currently work in testing
# People that currently do not work in testing have been excluded 
Current_testers <- which(mydata[,2] == "Yes")

#Apply this index to the data
mydata <- mydata[Current_testers,]

# Create a sub set of columns 30-53, these are true/false responses to positive and negative questions
# And also convert this sub set of true/false answers to logical vectors
HappyData <- apply(mydata[,30:53], 2, as.logical)

# Make a vector index of positive questions
pos_index <- c(1, 2, 4, 7, 8, 10, 11, 12, 14, 15, 20, 21)

# Make a vector index of negative questions
neg_index <- c(3, 5, 6, 9, 13, 16, 17, 18, 19, 22, 23, 24)

# Positive questions score +1 for each True answer, pos_score is a vector of scores from 0 to +12 
pos_score <- rowSums(HappyData[,pos_index])

# Negative questions score -1 for each True answer, neg_score is a vector of scores from 0 to -12  
neg_score <- -rowSums(HappyData[,neg_index])

# Add negative and positive scores to make the final score named Happiness Index
# The happiness index is a reflection of how positive or negative a job is
WorkplaceHappinessIndex <- pos_score+neg_score


# bind the Workplace Happiness Index onto the end of mydata
mydata <- cbind(mydata[,],WorkplaceHappinessIndex)

#make indexes for experience groups
lessthanone <- which(mydata[,14] == "less than a year")
onetotwo <- which(mydata[,14] == "1 - 2 years")
twotofive <- which(mydata[,14] == "2 - 5 years")
fivetoten <- which(mydata[,14] == "5 - 10 years")
tentotwenty <- which(mydata[,14] == "10 - 20 years")
twentyplus <- which(mydata[,14] == "More than 20 years")

#apply these indexes to the workplace happiness column
happylessthanone <- mydata[lessthanone,54]
happyonetotwo <- mydata[onetotwo,54]
happytwotofive <- mydata[twotofive, 54]
happyfivetoten <- mydata[fivetoten, 54]
happytentotwenty <- mydata[tentotwenty, 54]
happytwentyplus <- mydata[twentyplus, 54]

# Function to plot the Happiness of x
happy_plot <- function(x){
  breaks <- c(min(x):max(x))
  hist(x, 
       breaks = breaks,
       xlim = c(-12,12),
       xlab = "Workplace Happiness Index",
       col = rainbow(20),
       xaxt = "n",
       main = "Histogram of Happiness at work"
  )
  axis(1, at = seq(-12, 12, by = 1))
  abline(v = mean(x), col = "black", lty = 5, lwd = 2)
  legend(-12,15,
         legend=paste0("mean = ", round(mean(x), digits=1)), 
         col = "black", 
         lty = 5, 
         lwd = 2)
}

happy_plot(happylessthanone)
happy_plot(happyonetotwo)
happy_plot(happytwotofive)
happy_plot(happyfivetoten)
happy_plot(happytentotwenty)
happy_plot(happytwentyplus)


