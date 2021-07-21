## Linear Programming for Soda company 
---

![linear-regression](https://user-images.githubusercontent.com/42017072/117209027-7f103880-adfe-11eb-9151-4ee9b00e9b9e.png)


#### import library

```R
library(lpSolve)
```
---

#### <span style="color:Green">Objective Function</span>
- Max(13X<sub>1</sub> + 23X<sub>2</sub> + 30X<sub>3</sub>)

#### <span style="color:Green"> Subject to (Constraints)</span>
- 5X<sub>1</sub> + 15X<sub>2</sub> + 4X<sub>3</sub> <= 480 <span style="color:darkblue">(CO2)</span> 
- 4X<sub>1</sub> + 4X<sub>2</sub> + 10X<sub>3</sub> <= 160 <span style="color:darkblue">(Water)</span> 
- 35X<sub>1</sub> + 20X<sub>2</sub> + 15X<sub>3</sub> <= 1190 <span style="color:darkblue">(Flavor)</span> 
- 5X<sub>1</sub> + 10X<sub>2</sub> + 20X<sub>3</sub> <= 200 <span style="color:darkblue"> (number of worker * work hours * 5 days)</span> 
- X<sub>1</sub>, X<sub>2</sub>, X<sub>3</sub> >= 0 <span style="color:darkblue"> (We don't want a negative amount of  batches)</span>




### create Objective coeffation
```R
obj_coeff <- c(13,23,30)
```

### constraints matrix
```R
constraints <- matrix(
  c(
    5,15,4,
    4,4,10,
    35,20,15,
    5,10,20
  ), nrow =4, byrow= TRUE
)
```



### rename column and row names 
```R
colnames(constraints) = c("Strwaberry" , "Orange" , "Grape")
rownames(constraints) = c("CO2" , "Water" , "Flavor" , "Production Time")
View(constraints)

```



### create direction vector
```R
direction_c <- c("<=","<=","<=","<=") 
```

### create resources vectore
```R
resources <- c(480,160,1190,200) # 200 = number of employee * work hours * work day
```

### create linear programming object
```R
solve_lp <- lp(
  "max", # find max result
  obj_coeff,
  constraints,
  direction_c,
  resources
)

```

```R
solve_lp$objval # Objective value
solve_lp$solution # solution 
```


