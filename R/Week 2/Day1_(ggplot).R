# This assignment to complete exercises from Chapter 3 of R for Data Science https://r4ds.had.co.nz/data-visualisation.html
# install the packages
# install.packages("tidyverse")

library(tidyverse)

mpg

#########################
# 3.2.4 Exercises
# 1.
ggplot(data = mpg) # didn't see any thing 

# 2.
cat('Number of rows in mpg dataset: ',nrow(mpg),'\n') # number of rows
cat('Number of columns in mpg dataset: ',length(mpg),'\n') # number of columns

# 3.
?mpg

# 4. Scater PLot of hwy and cyl
mpg %>% 
  select(hwy, cyl) %>%
  ggplot(aes(x=hwy, y=cyl)) +
  geom_point() +
  ggtitle("Relation between highway miles and cylinders") +
  labs(x="highway miles per gallon", y="Number of cylinders")


# 5. Scater PLot of class and cyl
# This plot didn't give an usful information 
mpg %>% 
  select(class, cyl) %>%
  ggplot(aes(x=class, y=cyl)) +
  geom_point()+
  ggtitle("Relation between car class and cylinders") +
  labs(x="Class", y="Number of cylinders")
  


#########################
# 3.3.1 Exercises
# 1.
# Code provedid by website 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# Correct code, color is parameter in geom_points not in aes.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2.
cat('Categorical variables: \n')
cat('manufacturer, model, trans, drv, fl, class.\n')

cat('Continuous variables: \n ')
cat('displ, year, cyl, cty, hwy.\n')

# 3. 
# continuous variable can be mapped to color
plot1 <- ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl))

# continuous variable can be mapped to Size
plot2 <- ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl))

# continuous variable can not be mapped to shape
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = cyl))

# 4. What happens if you map the same variable to multiple aesthetics?
#    Answer: Both aesthetics shows on  plot 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl, color = cyl ))

# 5. What does the stroke aesthetic do? What shapes does it work with?
#   Answer: Use the stroke to modify the width of the border
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, stroke = displ))

# 6. What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))
?geom_point

##########################
# 3.5.1 Exercises
# 1. What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cyl, nrow = 2)

# 2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
#  Answer: The empty cells means there are no data for combination between these values
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl)) +
  facet_grid(drv ~ cyl)

# 3.What plots does the following code make? What does . do?
# This refer to no need to facet on columns 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

# This refer to no need to facet on rows
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)


# 4. What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? How might the balance change if you had a larger dataset?
#    Answer: use faceting is helps to see each  classe in seperated chart, 
#            I think this way not helpfull with large data. Because we need a lot charts.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# 5. 
?facet_wrap
cat('nrow refer to number of rows.\nncol refer to number of columns.')
cat('The facet_wrap have many options such: \n\nlabeller: A function that takes one data frame of labels and returns a list or data frame of character vectors.\n')

?facet_grid()
cat('The facet_grid() does not have nrow and ncol, because, It is most useful when you have two discrete variables.\n')


# 6. 
# If add more variable on the rows, It's harder to see actual values.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(class ~ drv)

######################
# 3.6.1 Exercises
# 1. 
ggplot(data = mpg) +
  geom_line(mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(x = displ, y = hwy))

# boxplot
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = displ)) 

# histogram
ggplot(data = mpg) +
  geom_histogram(mapping = aes(x = displ))

# 2. 
# Answer: I expected to see multi line because group by color = drv
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3.What does show.legend = FALSE do? What happens if you remove it?
# Why do you think I used it earlier in the chapter?
# Answer: Nothing change
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE, show.legend =  FALSE)

# 4. What does the se argument to geom_smooth() do? 
# Answer: Display confidence interval around smooth? (TRUE by default, see level to control.)
?geom_smooth


# 5. Will these two graphs look different? Why/why not?
# Answer: looks the same, because on the first graph layers inherit configuration form ggplot. 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# 6. 
#install.packages("gridExtra")

plot1 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(se = FALSE)
plot2 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE)
plot3 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) + 
  geom_point() +
  geom_smooth(se = FALSE)
plot4 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=drv)) +
  geom_smooth(se = FALSE)
plot5 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=drv)) +
  geom_smooth(se = FALSE, mapping = aes(linetype = drv))
plot6 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color=drv)) + 
  geom_point(shape = 21, color = "white", stroke = 1)
theme_set(theme_gray())
plot_grid(plot1, plot2, plot3, plot4, plot5, plot6, labels=c("1","2","3", "4","5","6"), ncol=2, nrow = 3)

##############################
# 3.7.1 Exercises

# 1. What is the default geom associated with stat_summary()?
?stat_summary
cat('The default geom for stat_summary is pointrange.\n')

#  How could you rewrite the previous plot to use that geom function instead of the stat function?
ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary"
  )

# 2. What does geom_col() do? How is it different to geom_bar()?
?geom_col
cat('The geom_bar()  makes the height of the bar proportional to the number of cases in each group.\n')
cat('The geom_col()  makes  the heights of the bars to represent values in the data.\n')

# 3.
cat('The are many geom pairs such: \n')
cat('1. geom_bar() \n2. geom_boxplot() \n3. geom_density() \n')
cat('4. geom_dotplot() \n5. geom_smooth() \n6. geom_hex() \n')


# 4. 
?stat_smooth()
cat("The stat_smooth Computed these variables:\n")
cat('y: predicted value.
ymin: lower value of the confidence interval.
ymax: upper value of the confidence interval.
se: standard error.')

#########################
# 3.8.1 Exercises
# 1. 
# Answer: There is overplotting. To improve the plot, used position = "jitter" to decrease overplotting
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

# 2. 
?geom_jitter()
cat('The following parameters control the amount of jittering: width and height.\n')

# 3. 
?geom_count()
cat('The geom_jitter() adds a small amount of random variation to the location of each point.\n')
cat('The geom_count() counts the number of observations at each location, then maps the count to point area.\n')

# 4. 
?geom_boxplot
cat('The defaul position is "dodge2".')
ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
  geom_boxplot()