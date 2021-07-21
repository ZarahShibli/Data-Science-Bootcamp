def countdown(num):
    ls = []
    for i in reversed(range(num+1)):
        ls.append(i)
    return ls
    
def print_and_return(ls):
    print(ls[0])
    return ls[1]
    
    
def first_plus_length(ls):
    return ls[0] + len(ls)
        
        
def length_and_value(num1 , num2):
    ls = [num2 for j in range(num1)]
    return ls
    
def values_greater_than_second(ls):
    if (len(ls)<2):
        return False
    else:
        new_list = []
        for i in range(len(ls)):
            if (ls[i]>ls[1]):
                new_list.append(ls[i])
        print(len(new_list))
        return new_list