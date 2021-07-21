
import random
def randInt(min=0 , max=100):
    if(max < 0):
        return ("The max is less than 0")
    elif (min > max):
        return ("The min greater than max")
       
    num = random.random() * (max - min) + min
    num = int(num)
    return num

print(randInt())    # should print a random integer between 0 to 100
print(randInt(max=50))     # should print a random integer between 0 to 50
print(randInt(min=50))     # should print a random integer between 50 to 100
print(randInt(min=50, max=500))    # should print a random integer between 50 and 500