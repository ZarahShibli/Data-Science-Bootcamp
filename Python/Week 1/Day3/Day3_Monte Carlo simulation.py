import numpy as np
from scipy import stats
import math

def prob(y):
    print("The number of people with a probability of:",y)

    birthdays=365

    #trials
    z=5
    for i in range(z):
        
        results = np.array([])
        for people in range(1,25):
             #return a random num from 1to 365 representing a birth date
            birthdate=np.random.randint(1,birthdays+1,people)

            if len(birthdate) == len (set(birthdate)):
                     results = np.append(results,0)
            else:
                results = np.append(results,1)
            x=sum(results)       
            probablity=x/z
            if (probablity > y):
                print("The probablity of ",people," people have same birthday is ",probablity)
prob(0.5) 
prob(0.95)
prob(0.99)