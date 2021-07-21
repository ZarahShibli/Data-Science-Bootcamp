# 1. print the number between 1 and 100 
for i in range(1,101):
    print(i)



# 2. print the number between 1 and 100 divisible by 8 
for i in range(1,101):
    if (i%8==0):
        print(i)


# 3. Use a while loop to find the first number divisible by 5
div_by_5 = []
i = 0 
while (len(div_by_5) < 20):
    if (i%5==0):
        div_by_5.append(i)
    i+=1
print(div_by_5)


# 4. 

def prime(num):
    isPrime = True
    if(num >0 and num <101):
        for i in range(2,101):
            if (num!= i and num%i ==0):
                isPrime = False
        return ((str(num)+" is prime") if isPrime==True else (str(num)+" is not prime"))
        
    else:
        print("Only allow values between 0 and 100")
        
prime(213)