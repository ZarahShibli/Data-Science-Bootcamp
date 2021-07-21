# simulating the total revenue earned each day for a movie theater 
# import libraries
import numpy as np 
import pandas as pd
import matplotlib.pyplot as plt
import math


# In[2]:



def one_sample(low, high):
    """
    Generates a random sample of visitors: adults, children and seniors
    parameters
    ----------
    low: the lowest value 
    high: the highest value 
    
    
    return
    ------
    random sample of visitors
    
    """
    return np.random.randint(low=low, high=high,size=1)[0] 


def revenue(visitors, cost):
    """
    This function multiples two lists to return the total revenue for all visitors
    parameters
    ----------
    visitors: list
              number of the visitors for children, seniors and adults
              
    cost: list 
          cost of ticket for children, seniors and adults
    
    return
    ------
    total : int 
            total revenue per day
    
    """
    cost_list = np.multiply(visitors,cost)
    total = sum(cost_list)
    return total


# In[3]:


ticket_cost = [10, 15, 20]  # ticket cost child , senior , adults
visitors = []  # to store number of visitors

# data frame contening the movie
data = {
    "Movie Name": [
        "The Lion King",
        "Mad Max",
        "The Lord Of The Ring",
        "Star Wars",
        "Toy Story",
    ]
}

movies = pd.DataFrame(data, columns=["Movie Name"])

# data frame contening the days
days_name = {
    "Day": ["Sat", "Sun", "Mon", "Thues", "Wed", "Thurs", "Fri"],
    "Revenue": np.zeros(7),
}

revenue_per_day = pd.DataFrame(days_name, columns=["Day", "Revenue"])

screens = 5  # number of screens

seats = 100  # num of seats each theater has
week_days = np.zeros(7)  # list to store revenue

currentTotal = 0  # to store total revenue for each movie
total = 0  # to store revenue per day

sim = 1000  # number of simulation


# In[4]:


# simulation 1000 times
for s in range(sim):
    
    # Iterate through the week
    for i in range(len(week_days)) : 
        
        total = 0
        # Iterate through the amount of screens on a particular day
        for j in range (0,screens):

            # Generates a random sample of visitors: adults, children and seniors
            visitors_adults = one_sample(0,seats)
            visitors_child = one_sample(0, (seats - visitors_adults))
            visitors_senior = one_sample(0, (seats - (visitors_adults + visitors_child)))
           
            # store number of visitors for children, seniors and adults
            visitors = [visitors_child, visitors_senior,visitors_adults ]
            
            # calculate total revenue 
            currentTotal = revenue(visitors, ticket_cost)

            # calculate total revenue per day
            total += currentTotal 

        # store total revenue per day in the list
        week_days[i] = week_days[i] + total 


# highest summed revenue
revenue_per_day['Revenue'] = week_days

revenue_per_day


# In[8]:


# graph that shows revenue per day

y = revenue_per_day['Revenue']
low = min(y)
high = max(y)
plt.ylim([math.ceil(low-0.5*(high-low)), math.ceil(high+0.5*(high-low))])

plt.bar(revenue_per_day['Day'],revenue_per_day['Revenue'])
plt.title('Revenue per day')
plt.xlabel('Days')
plt.ylabel('Revenue $')
plt.show()


# ### Questions:
# 1. **Talk about how you refactored your code and made improvements**
# 
#     - Create functions for repeated code part and calculate revenue 
#         - `one_sample(low, high)`
#         - `revenue(visitors, cost)`
# 
#     -  Use a list instead of multiple variables. 
#         - `ticket_cost = [10, 15, 20] ` instand of `ticket_cost_child = 10, ticket_cost_senior =15, ticket_cost_adults = 20`
#         - `visitors = [visitors_child, visitors_senior,visitors_adults ]`
#     - Use DataFrame to store revenue for each day
#         - `revenue_per_day = pd.DataFrame(days_name, columns=["Day", "Revenue"])`
# 
# 
# 
# 2. **What challenges you faced**
#     - We tried differant packages and methods to generate random number, some of them required spcific input type, like `Ranmdom.Sample()` this function take a list as input. We need to pass int number as input to function, so, we used `np.random.randint`.
#     
#     
# 3. **What changes you would like to make if you had more time.**
#     - Calculating the cost based on the number of the movie view.
#     - Store the number of visitors to find out the most visitors from which category?
#     
# 
