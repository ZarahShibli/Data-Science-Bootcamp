# import library

#install.packages('lpSolve')
#install.packages('expm')
#install.packages("markovchain")
#install.packages("diagram")
library(markovchain)
library(diagram)
library(lpSolve)
library(expm)

###############
# Part-1
?lp

# create Objective coeffation
obj_coeff <- c(13,23,30)

# constraints matrix
constraints <- matrix(
  c(
    5,15,4,
    4,4,10,
    35,20,15,
    5,10,20
  ), nrow =4, byrow= TRUE
)

# rename column and row names 
colnames(constraints) = c("Strwaberry" , "Orange" , "Grape")
rownames(constraints) = c("CO2" , "Water" , "Flavor" , "Production Time")
View(constraints)

# create direction vector
direction_c <- c("<=","<=","<=","<=")

# create resources vectore
resources <- c(480,160,1190,200) # 200 = number of employee * work hours * work day


# create linear programming object
solve_lp <- lp(
  "max", # find max result
  obj_coeff,
  constraints,
  direction_c,
  resources
)

solve_lp$objval # Objective value
solve_lp$solution # solution

##################
# Part-2

# Update matrix with new percentage to improve probability
trans_matrix<- matrix(c(
  0.80, 0.05, 0.05,0.1,
  0.05, 0.80, 0.10,0.05,
  0.10, 0.05, 0.80,0.05,
  0.05, 0.1, 0.05,0.80
), nrow=4, byrow = TRUE)


# Display the matrix
trans_matrix

# trans_matrix after 1 period
trans_matrix %^% 2

# create the Discrete Time Markov Chain
trans_matrix <- new("markovchain",transitionMatrix=trans_mat, states=c("0","1","2","3"), name="MC 1") 

# plot the Markov Chain status
plot(trans_matrix, order = 1, digits = 2, minProbability = 0)