# Team Members

# Zarah Shibli
# Fatimah Moneer Al-Rashed
# Abdulrahman Aljubaylan
# Rawan Alsaedi
########################

# Potential Questions to Answer:
# 1. Create snacks that the customers can buy and randomize who buys which snack
# 2. Pretend you own multiple theaters and run two simulations to represent each theater and plot the results
# 3. Create conditional statements for movies that may be PG-13 and children are not allowed to watch (Done)


# Cost for adults and children
ticket_cost <- 5
ticket_cost_child <- 10 

# List 5 of your favorite movies
movies <- data.frame(
  movie_name = c('Fireproof', 'Waitress', 'Twilight', 'Shooter', 'Proposal'),
  allowed_for_child = c("No","No","Yes","Yes","Yes")
  
)

screens <- 1:5 # How many screens does the theater have? (assume 1 per movie)
total_seats = 150 # How many seats does each theater hold
seats <-  (1:total_seats) # Range of seats on each theater hold
week_days <- rep(0, 7)  # Store totals for each day

visitors_adults <- data.frame() # Store number of adults visitors for each day
visitors_children <- data.frame() # Store number of children visitors for each day 

    # iterate through the week
    for (i in 1:length(week_days)){
      
      # Keep track of total revenue for the day
      
      visitors_per_day_adults = list() # Store the count watching adults  for each movie
      visitors_per_day_children = list() # Store the count watching Children  for each movie
      
      # iterate through the amount of screens on a particular day
      for (j in screens) {
        
        # Calculate how many adults and children are watching the movie
        
        # check if allowed for children to watch this movie or not
        if (movies$allowed_for_child[j]=="Yes"){
          visitors_adults_sample <- sample(seats, 1) # Return a random number for adults visitors number 
          visitors_children_sample <- sample((total_seats-visitors_adults_sample),1) # Return a random number for children visitors number 
        }
        else{
          visitors_adults_sample <- sample(seats, 1)
          visitors_children_sample = 0 # Set children visitors number by 0, because not allowed for children to watch this movie
        }
        
        # Calculate the revenue for adults and children
        revenue_adults = visitors_adults_sample * ticket_cost 
        revenue_children = visitors_children_sample * ticket_cost_child
        
        # Calculate revenue, and add to running total for the day
        total_per_day= revenue_adults + revenue_children
        
        # Additional feature: Count number of visitors for adults and children
        visitors_per_day_adults[j] <- visitors_adults_sample
        visitors_per_day_children[j] <- visitors_children_sample

      }
      # Save total to the corresponding day
      week_days[i] <- total_per_day
      
      # Store adults and children visitors number into dataframes
      visitors_adults <- rbind(visitors_adults, visitors_per_day_adults)
      visitors_children <- rbind(visitors_children, visitors_per_day_children)
    }
    
    # Rename column names
    colnames(visitors_adults) <- movies$movie_name
    colnames(visitors_children) <- movies$movie_name
    
    # View data
    View(visitors_adults)
    View(visitors_children)
   
    # Make a barchart showing total revenue per day
    # Which day had the highest revenue? 
    
    
        max_value = max(week_days) # find maximum revenue
        
        # Coloring the maximum total revenue per day
        colors <- ifelse(week_days == max_value,"green","gray")
        
        # create a bar plot fot the revenue per day
        barplot(
          week_days,
          main = "Total Revenue per Day",
          xlab = "Day",
          ylab = "Total Revenue",
          names.arg = c("Sat","Sun","Mon","Thues","Wed","Thurs","Fri"),
          col = colors # add color vector
          )
        
   
        
    # Make any other chart
        
        # Ploting number of watchers for each movie based on age (Adults or Children)
        visitors_list <- list(adults=colSums(visitors_adults),children = colSums(visitors_children))
        visitors_list
        
        par(
          mfrow=c(1,2), 
          mar=c(1,1)) # used to fix the error "figure margins to large")
        
        barplot(
          visitors_list$adults,
          main = "Total of Adults watchers for each movie",
          xlab = "Movies",
          ylab = "Number of watchers",
          col = c("red")
        )
        
        barplot(
          visitors_list$children,
          main = "Total of children watchers for each movie ",
          xlab = "Movies",  
          ylab = "Number of watchers",
          col = c("green")
        )
        