
setwd ("/Dev/Git/shiny_testers") 
#setwd("/git/shiny_testers")

library(shiny) # load shiny

#Read data
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

make_index <- function(input1,input2,input3,input4,input5,input6,input7,input8,col1,col2,col3,col4,col5,col6,col7,col8){

 #make an index from experience checkbox selection    
 ind1 <- which(mydata[,col1] == input1[1])
 ind2 <- which(mydata[,col1] == input1[2])
 ind3 <- which(mydata[,col1] == input1[3])
 ind4 <- which(mydata[,col1] == input1[4])
 ind5 <- which(mydata[,col1] == input1[5])
 ind6 <- which(mydata[,col1] == input1[6])

 index_experience <- c(ind1,ind2,ind3,ind4,ind5,ind6)

 #make an index from happy group radio button selection
 switch(input2[1], 
        "Yes"={index_happy <- which(mydata[,col2] == input2[1])},
        "No"={index_happy <- which(mydata[,col2] == input2[1])},
        "b"={index_happy <- which((mydata[,col2] == "Yes") | (mydata[,col2] == "No"))}
        )
  
 #make an index from qualification checkbox selection
 ind1 <- which(mydata[,col3] == input3[1])
 ind2 <- which(mydata[,col3] == input3[2])
 ind3 <- which(mydata[,col3] == input3[3])
 ind4 <- which(mydata[,col3] == input3[4])
 ind5 <- which(mydata[,col3] == input3[5])
 ind6 <- which(mydata[,col3] == input3[6])
 ind7 <- which(mydata[,col3] == input3[7])
 
 index_quals <- c(ind1,ind2,ind3,ind4,ind5,ind6,ind7)
 
 #make an index from studied computing radio button selection
 switch(input4[1], 
        "Yes"={index_comp <- which(mydata[,col4] == input4[1])},
        "No"={index_comp <- which(mydata[,col4] == input4[1])},
        "b"={index_comp <- which((mydata[,col4] == "Yes") | (mydata[,col4] == "No"))}
 )
 
 #make an index for looking for test job
 ind1 <- which(mydata[,col5] == input5[1])
 ind2 <- which(mydata[,col5] == input5[2])
 ind3 <- which(mydata[,col5] == input5[3])
 ind4 <- which(mydata[,col5] == input5[4])
 ind5 <- which(mydata[,col5] == input5[5])
 
 index_testjob <- c(ind1,ind2,ind3,ind4,ind5)
 
 
 #make an index for looking for a not test job
 ind1 <- which(mydata[,col6] == input6[1])
 ind2 <- which(mydata[,col6] == input6[2])
 ind3 <- which(mydata[,col6] == input6[3])
 ind4 <- which(mydata[,col6] == input6[4])
 ind5 <- which(mydata[,col6] == input6[5])
 
 index_nottestjob <- c(ind1,ind2,ind3,ind4,ind5)
 
 #make an index from different job radio button selection
 switch(input7[1], 
        "Yes, I had a different job before I started testing"={index_diffjob <- which(mydata[,col7] == input7[1])},
        "No, my very first job was a testing job."={index_diffjob <- which(mydata[,col7] == input7[1])},
        "b"={index_diffjob <- which((mydata[,col7] == "Yes, I had a different job before I started testing") | (mydata[,col7] == "No, my very first job was a testing job."))}
 )
 
 #make an index from want to be a tester while studying radio button selection
 switch(input8[1], 
        "Yes"={index_study <- which(mydata[,col8] == input8[1])},
        "No"={index_study <- which(mydata[,col8] == input8[1])},
        "b"={index_study <- which((mydata[,col8] == "Yes") | (mydata[,col8] == "No"))}
 )
 
 
 # combine first two indexes
 combined_index <- c(index_happy, index_experience)
 
 # only care about index numbers which appear in both these indexes, ie. are duplicates
 dupes <- combined_index [duplicated(combined_index)]

 # combine the duplicate indexes with next index
 combined_index <- c(dupes, index_quals) 
 
 # only care about index numbers which are duplicates  
 dupes <- combined_index [duplicated(combined_index)]
 
 # combine the duplicate indexes with next index
 combined_index <- c(dupes, index_comp) 
 
 # only care about index numbers which are duplicates  
 dupes <- combined_index [duplicated(combined_index)]

 # combine the duplicate indexes with next index
 combined_index <- c(dupes, index_testjob) 
 
 # only care about index numbers which are duplicates  
 dupes <- combined_index [duplicated(combined_index)]
 
 # combine the duplicate indexes with next index
 combined_index <- c(dupes, index_nottestjob) 
 
 # only care about index numbers which are duplicates  
 dupes <- combined_index [duplicated(combined_index)]
 
 # combine the duplicate indexes with next index
 combined_index <- c(dupes, index_diffjob) 
 
 # only care about index numbers which are duplicates  
 dupes <- combined_index [duplicated(combined_index)]
 
 # combine the duplicate indexes with next index
 combined_index <- c(dupes, index_study) 
 
 # in final index only care about index numbers which are duplicates  
 final_index <- combined_index [duplicated(combined_index)]
 
 print(final_index)
 return(final_index)
  
} 

apply_index <- function(index, col){
  # remove 0's from this index if there are any
  index_to_plot <- index[index != 0]
  data <- mydata[index_to_plot,col]
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
       main = "Histogram of Happiness at work"
  )
  axis(1, at = seq(-12, 12, by = 1))
  abline(v = mean(x), col = "black", lty = 5, lwd = 2)
  abline(v = median(x), col = "grey", lty = 5, lwd = 2)
  legend("topleft",
         legend= c(paste0("mean = ", round(mean(x), digits=1)),paste0("median = ", round(median(x), digits=1))) , 
         col = c("black","grey"), 
         lty = 5, 
         lwd = 2)

}

?legen

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



