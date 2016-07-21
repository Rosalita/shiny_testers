
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

experience <- (mydata[,14])
levels(experience)
explevels <- factor(experience, levels(experience)[c(6,2,4,5,3,7)])
explevels <- levels(explevels)

make_index <- function(input1,input2,col1,col2){
  
 ind1 <- which(mydata[,col1] == input1[1])
 ind2 <- which(mydata[,col1] == input1[2])
 ind3 <- which(mydata[,col1] == input1[3])
 ind4 <- which(mydata[,col1] == input1[4])
 ind5 <- which(mydata[,col1] == input1[5])
 ind6 <- which(mydata[,col1] == input1[6])

 index_experience <- c(ind1,ind2,ind3,ind4,ind5,ind6)

 switch(input2[1], 
        "Yes"={index_happy <- which(mydata[,col2] == input2[1])},
        "No"={index_happy <- which(mydata[,col2] == input2[1])},
        "b"={index_happy <- which((mydata[,col2] == "Yes") | (mydata[,col2] == "No"))}
        )
  
 #combine indexes
 all <- c(index_happy, index_experience)
 # only interested in index which appear in both, ie. are duplicates
 multi_index <- all [duplicated(all)]

# note for three inputs may need to appy unique() to this
# unique(all[duplicated(all)])

 return(multi_index)
  
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
  legend("topleft",
         legend=paste0("mean = ", round(mean(x), digits=1)), 
         col = "black", 
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



