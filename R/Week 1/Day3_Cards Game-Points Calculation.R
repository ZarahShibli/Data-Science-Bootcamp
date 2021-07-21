# This function to shuffling deck cards 
shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  print(random)
  cards[random, ]
}

# This function for  deal the cards to players 
deal <- function(cards,num_players,num_cards){
  
  # create a vector to store the players' cards.
  playersCards <- c() 
  
  # deal out num_cards per player
  for(i in 1:num_players){
    
    # dealing the cards to players based on the num_cards
    r = (num_cards*i-(num_cards-1)):(num_cards*i)
    
    # check if the remaining cards equal the number of required cards for each player
    if (length(r[r<nrow(cards)])==num_cards){
      player1 <- list(cards[r,]) # store selected cards on the list  
      playersCards$Player[i] = player1 # add a new column in vector for this player
    }
    
    # if the remaining cards less than num_cards, then display these messages and break from the condition
    else{
      cat("There are not enough cards for everyone.\n")
      cat("Only ",i-1," players can play game.\n")
      break
    }
  }
  # return the vector cards for all players
  return (playersCards)
}

# This function to calculate the players points 
points <- function(Players_Cards, num_players ,num_cards){
  
  # create a vector to store the players' points
  players_points <- c()

  # calculate points for each players 
  for (i in 1:num_players){
    sum = 0 # the total of points
    palyer_point = sum(Players_Cards$Player[[i]]$value) # return the value for this palyer
    
    # sum the point for player
    for (j in 1:num_cards){
      sum = sum +palyer_point[j]
    }
    
    # display player info and points
    cat('Player ',i,' has ',sum,'points. \n')
    players_points[i] = sum
  }
  
  # return all players points
  return (players_points)
}

# load data
deck <- read.csv("https://gist.githubusercontent.com/garrettgman/9629323/raw/ee5dfc039fd581cb467cc69c226ea2524913c3d8/deck.csv") 

# shuffle cards 
cards <- shuffle(deck)

num_players = 3
num_cards = 5

# deal
Players_Cards <- deal(cards,num_players,num_cards)
cat("The players careds: \n") # display the results
Players_Cards

num_current_palyers <- length(Players_Cards$Player) # current number of players

# calculate the players points 
players_points <- points(Players_Cards,num_current_palyers,num_cards) 

max_value = max(players_points) # find maximum points
player_with_max_value <- which(players_points==max_value) # find the player have the maximum points
player_with_max_value_str <- paste(player_with_max_value, collapse = ",") # if there are more than player have max points
cat("Player ",player_with_max_value_str, " has max points, with points: ",max_value) # display the results