
setwd ("/Dev/Git/shiny_testers") 
#setwd("/git/shiny_testers")

library(shiny) # load shiny

#Read data
#mydata <- read.csv("data/survey_results_raw.csv", header = TRUE, sep =",")
mydata <- read.csv("C:/Dev/Git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")
#mydata <- read.csv("/git/shiny_testers/data/survey_results_raw.csv", header = TRUE, sep =",")

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

#extract the levels of experience so these can be used on the ui
experience <- (mydata[,14])
#check levels
levels(experience)
#looks like they are arranged alphabetically so change order from shortest to longest instead
# Also don't include level 1 because this is just blank ""
explevels <- factor(experience, levels(experience)[c(6,2,4,5,3,7)])
explevels <- levels(explevels)

#extract the levels of qualifications so these can be used on the ui
quals <- (mydata[,17])
#check levels
levels(quals)
#looks like arrange alphabetically so change order to difficulty order instead
# Also don't include level 1 because this is just blank ""
quals <- factor(quals, levels(quals)[c(8,6,2,5,3,7,4)])
quals <- levels(quals)  

#extract the levels of likelihood to look for a new testing job
testjob <- (mydata[,9])
levels(testjob)
testjoblevels <- factor(testjob, levels(testjob)[c(6,4,3,2,5)])
testjoblevels <- levels(testjoblevels)

#extract the levels of likelihood to look for a job outside of testing
nottestjob <- (mydata[,10])
levels(nottestjob)
nottestjoblevels <- factor(nottestjob, levels(nottestjob)[c(6,4,3,2,5)])
nottestjoblevels <- levels(nottestjoblevels)

#extract the levels of likelihood to recommend testing to others
recommend <- (mydata[,13])
levels(recommend)
recommendlevels <- factor(recommend, levels(recommend)[c(6,4,3,2,5)])
recommendlevels <- levels(recommendlevels)


make_exp_index <- function(input,col){
  ind1 <- which(mydata[,col] == input[1])
  ind2 <- which(mydata[,col] == input[2])
  ind3 <- which(mydata[,col] == input[3])
  ind4 <- which(mydata[,col] == input[4])
  ind5 <- which(mydata[,col] == input[5])
  ind6 <- which(mydata[,col] == input[6])
  
  index_experience <- c(ind1,ind2,ind3,ind4,ind5,ind6)
  return(index_experience)
}

make_happy_index <- function(input,col){
  switch(input[1], 
         "Yes"={index_happy <- which(mydata[,col] == input[1])},
         "No"={index_happy <- which(mydata[,col] == input[1])},
         "b"={index_happy <- which((mydata[,col] == "Yes") | (mydata[,col] == "No"))}
  )
  return(index_happy)
}

make_quals_index <- function(input,col){
  ind1 <- which(mydata[,col] == input[1])
  ind2 <- which(mydata[,col] == input[2])
  ind3 <- which(mydata[,col] == input[3])
  ind4 <- which(mydata[,col] == input[4])
  ind5 <- which(mydata[,col] == input[5])
  ind6 <- which(mydata[,col] == input[6])
  ind7 <- which(mydata[,col] == input[7])
  index_quals <- c(ind1,ind2,ind3,ind4,ind5,ind6,ind7)
  return(index_quals)
}

make_comp_index <- function(input,col){
  switch(input[1], 
         "Yes"={index_comp <- which(mydata[,col] == input[1])},
         "No"={index_comp <- which(mydata[,col] == input[1])},
         "b"={index_comp <- which((mydata[,col] == "Yes") | (mydata[,col] == "No")| mydata[,col] == "")}
  )
  return(index_comp)
}

make_testjob_index <- function(input,col){
  ind1 <- which(mydata[,col] == input[1])
  ind2 <- which(mydata[,col] == input[2])
  ind3 <- which(mydata[,col] == input[3])
  ind4 <- which(mydata[,col] == input[4])
  ind5 <- which(mydata[,col] == input[5])
  index_testjob <- c(ind1,ind2,ind3,ind4,ind5)
  return(index_testjob)
}

make_nottestjob_index <- function(input,col){
  ind1 <- which(mydata[,col] == input[1])
  ind2 <- which(mydata[,col] == input[2])
  ind3 <- which(mydata[,col] == input[3])
  ind4 <- which(mydata[,col] == input[4])
  ind5 <- which(mydata[,col] == input[5])
  index_nottestjob <- c(ind1,ind2,ind3,ind4,ind5)
  return(index_nottestjob)
}

make_diffjob_index <- function(input,col){
  switch(input[1], 
         "Yes, I had a different job before I started testing"={index_diffjob <- which(mydata[,col] == input[1])},
         "No, my very first job was a testing job."={index_diffjob <- which(mydata[,col] == input[1])},
         "b"={index_diffjob <- which((mydata[,col] == "Yes, I had a different job before I started testing") | (mydata[,col] == "No, my very first job was a testing job."))}
  )
  return(index_diffjob)
}

make_study_index <- function(input,col){
  switch(input[1], 
         "Yes"={index_study <- which(mydata[,col] == input[1])},
         "No"={index_study <- which(mydata[,col] == input[1])},
         "b"={index_study <- which((mydata[,col] == "Yes") | (mydata[,col] == "No")| mydata[,col] == "")}
  )
}

make_recommend_index <- function(input,col){
  ind1 <- which(mydata[,col] == input[1])
  ind2 <- which(mydata[,col] == input[2])
  ind3 <- which(mydata[,col] == input[3])
  ind4 <- which(mydata[,col] == input[4])
  ind5 <- which(mydata[,col] == input[5])
  index_recommend <- c(ind1,ind2,ind3,ind4,ind5)
  return(index_recommend)
}

make_train_index <- function(input,train1,train2, train3, train4, train5, train6, train7){
  
  switch(input[1],
         "All testers"={index_train <- which((mydata[,train1] == "0")| 
                                             (mydata[,train1] == "1")| 
                                             (mydata[,train1] == "2")|
                                             (mydata[,train1] == "3")|
                                             (mydata[,train1] == "4")|
                                             (mydata[,train1] == "5"))},
         "Rapid Software Testing"=   {index_train <- which(mydata[,train1] != "0")},
         "AST BBST Foundations"=     {index_train <- which(mydata[,train2] != "0")},
         "AST BBST Bug Advocacy"=    {index_train <- which(mydata[,train3] != "0")},
         "AST BBST Test Design"=     {index_train <- which(mydata[,train4] != "0")},
         "ISEB/ISTQB Foundation"=    {index_train <- which(mydata[,train5] != "0")},
         "ISEB/ISTQB Advanced"=      {index_train <- which(mydata[,train6] != "0")},
         "ISEB/ISTQB Expert"=        {index_train <- which(mydata[,train7] != "0")},
         "None of the above courses"={index_train <- which((mydata[,train1] == "0")& 
                                                           (mydata[,train2] == "0")& 
                                                           (mydata[,train3] == "0")&
                                                           (mydata[,train4] == "0")&
                                                           (mydata[,train5] == "0")&
                                                           (mydata[,train6] == "0"))}
  )
  
  return(index_train)
}


present_in_all <- function(index_list){
  # combine first two indexes
  combined_index <- c(index_list[[1]], index_list[[2]])
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[3]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[4]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[5]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[6]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[7]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[8]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[9]]) 
  
  # only care about index numbers which are duplicates  
  dupes <- combined_index [duplicated(combined_index)]
  
  # combine the duplicate indexes with next index
  combined_index <- c(dupes, index_list[[10]]) 
  
  final_list <- combined_index [duplicated(combined_index)]
  
  return(final_list)
}

apply_index <- function(index, col){
  
  index <- as.numeric(unlist(index))
  data <- mydata[index,col]
  return(data)
}

  
# Function to plot the Happiness of x
happy_plot <- function(x){

  if(length(x) > 1){
    breaks <- c(min(x):max(x))
  } else {
    breaks <- c(x,(x+1))
  } 

  hist(x, 
       breaks = breaks,
       xlim = c(-12,12),
       xlab = "Workplace Happiness Index",
       col = rainbow(20),
       xaxt = "n",
       yaxt = "n",
       main = "Histogram of Happiness at work"
  )
  axis(1, at = seq(-12, 12, by = 1))

  totals <- table(x)
  largest_value <- (max(totals))
  
  if(largest_value <= 10){
    axis(2, at = seq(0, length(x), by = 1))
  }
  
  if ((largest_value > 10) & (largest_value <= 20)){
    axis(2, at = seq(0, length(x), by = 2))
  }
  
  if ((largest_value  > 20) & (largest_value  <= 50)){
    axis(2, at = seq(0, length(x), by = 5))
  }
  
  if (largest_value  > 50){
    axis(2, at = seq(0, length(x), by = 10))
  }
  
  axis(2, at = seq(0, length(x), by = 2))
  abline(v = mean(x), col = "black", lty = 5, lwd = 2)
  abline(v = median(x), col = "grey", lty = 5, lwd = 2)
  legend("topleft",
         legend= c(paste0("mean = ", round(mean(x), digits=1)),paste0("median = ", round(median(x), digits=1))) , 
         col = c("black","grey"), 
         lty = 5, 
         lwd = 2)

}

make_bar <- function(x, text){
 
   x <- as.logical(x)
   datatable <- table(x)
 
   if (length(x) > 0){ # if one of the check boxes has been selected
     if (all(x)){ # and the data to plot is all TRUE values
       
       # Append a 0 to the table
       datatable <- append(datatable,0)
       
       # change table names to be the correct way around 
       names(datatable) <- c("FALSE", "TRUE")
       
       #swapping existing value and 0 into right places so all plots remain consistent
       y <- datatable[1] 
       datatable[2] <- y
       datatable[1] <- 0
  
     } 
    
     if (all(!x)){ # if all the data to plot is FALSE
       
       # Append a 0 to the table
       datatable <- append(datatable,0)
       
       # Add the missing TRUE name
       names(datatable) <- c("FALSE", "TRUE")
     }
   }

  
  totals <- as.numeric(datatable[1:2])
  
  length(x)
  
  perc <- round((totals / length(x)) * 100, digits = 1)
  perc <- paste0(perc, "%")
  
  # Change axis orientation
  par(las = 2)
  midpoints <- barplot(datatable,
          col = c("magenta", "cyan"),
          main = text,
          ylim = c(0,205),
          xlim = c(0,2.5))
 text(midpoints, 3, totals ,cex=1, pos=3) 
 text(midpoints, 3, perc ,cex=1, pos=3, offset = 16.2) 
}



