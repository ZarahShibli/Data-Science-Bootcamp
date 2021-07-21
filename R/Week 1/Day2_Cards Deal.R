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

# load data
deck <- read.csv("https://gist.githubusercontent.com/garrettgman/9629323/raw/ee5dfc039fd581cb467cc69c226ea2524913c3d8/deck.csv") 

# shuffle cards 
cards <- shuffle(deck)

# deal
Players_Cards <- deal(cards,15,4)
cat("The players careds: \n") # display the results
Players_Cards