def selection_sort(list):
    n = len(list) # length of the list
    
    # iterate through the list elements starting from the first element to the end of the list
    for i in range(n): 
        min = i  # assume the first element has a minimum value 
        
        # iterate through the list elements from the next element (i+1) to the end of the list
        for j in range(i+1, n): 
            
              # check if the element in j index is smaller than the current minimum, then assign j as min 
            if (list[j] < list[min]):
                min = j
        
        print("Iteration #",i,":List",list)  # to show change on the list after updates
        # swapping the element has the minimum value with the element existing in index (i)  
        temp = list[i]
        list[i] = list[min]
        list[min] = temp
    
    # return the list after sorted 
    return list