
# Ex-1 Update Values in Dictionaries and Lists

x = [ [5,2,3], [10,8,9] ] 
students = [
     {'first_name':  'Michael', 'last_name' : 'Jordan'},
     {'first_name' : 'John', 'last_name' : 'Rosales'}
]
sports_directory = {
    'basketball' : ['Kobe', 'Jordan', 'James', 'Curry'],
    'soccer' : ['Messi', 'Ronaldo', 'Rooney']
}
z = [ {'x': 10, 'y': 20} ]

###########
# Solutions
# 1. Change the value 10 in x to 15.
x[1][0] = 15

# 2. Change the last_name of the first student from 'Jordan' to 'Bryant'
students[0]['last_name'] = 'Bryant'

# 3. In the sports_directory, change 'Messi' to 'Andres'
sports_directory['soccer'][0] = 'Andres'

# 4. Change the value 20 in z to 30
z[0]['y'] = 30

x , students, sports_directory, z

##############

# Ex-2 Iterate Through a List of Dictionaries
students = [
         {'first_name':  'Michael', 'last_name' : 'Jordan'},
         {'first_name' : 'John', 'last_name' : 'Rosales'},
         {'first_name' : 'Mark', 'last_name' : 'Guillen'},
         {'first_name' : 'KB', 'last_name' : 'Tonel'}
    ]

def iterateDictionary(ls):
    for i in range(len(ls)):
        print("first_name  - ",ls[i]['first_name'],', last_name - ',ls[i]['last_name'] )

        
iterateDictionary(students) 


##############
# Ex-3 Get Values From a List of Dictionaries

def iterateDictionary2(key_name, ls):
    for i in range(len(ls)):
        print(ls[i][key_name])

iterateDictionary2('first_name', students)
print("")
iterateDictionary2('last_name', students)

##############
# Ex-4 Iterate Through a Dictionary with List Values

def printInfo(dic):
    for i,j in dic.items():
        count = len(j)
        print(count,' ',i.upper())
        for c in j:
            print(c)
        print("")


dojo = {
   'locations': ['San Jose', 'Seattle', 'Dallas', 'Chicago', 'Tulsa', 'DC', 'Burbank'],
   'instructors': ['Michael', 'Amy', 'Eduardo', 'Josh', 'Graham', 'Patrick', 'Minh', 'Devon']
}

printInfo(dojo)