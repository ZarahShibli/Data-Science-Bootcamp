# Assignment 1 
rolling_sum <- function(x, size) {
  
   dice <- sample(x, size, replace = TRUE)
  print(dice)
   cat("The sum of all dice values is",sum(dice),"\n")
  rolling_sum1(dice,x)
}
#Assignment 1 Optional
rolling_sum1 <- function(dice, x) {
  
  if (length(x)<11){
    count <- sum(length(dice[dice>6]))
    cat ("The count of numbers greater than 6 is ", count)
  }
  else {
    count1 <- sum(length(dice[dice>16]))
    cat ("The count of numbers greater than 16 is ", count1)
  }
}
#Calling Functions
#10 Sided Dice
rolling_sum (1:10, 6)
#20 Sided Dice
rolling_sum (1:20, 6)