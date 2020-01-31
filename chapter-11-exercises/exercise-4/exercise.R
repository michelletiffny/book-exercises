# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library("nycflights13")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
View(flights)
nrow(flights)
ncol(flights)
colnames(flights)
??flights

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- mutate(flights, time_gained_or_lost = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, -time_gained_or_lost)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame


# Make a histogram of the amount of time gained using the `hist()` function


# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
summarize(flights, avg = mean(time_gained_or_lost, na.rm = TRUE))

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
flights %>% 
  filter(dest == "SEA") %>% 
  select(origin, dest, time_gained_or_lost) %>% 
  summarize(avg_delayed = mean(time_gained_or_lost, na.rm = TRUE)) %>% 
  pull(avg_delayed)

#or
to_sea <- filter(flights, dest == "SEA")
to_sea <- select(to_sea, origin, dest, time_gained_or_lost)

# On average, did flights to SeaTac gain or loose time?
summarize(to_sea, avg = mean(time_gained_or_lost, na.rm = TRUE))

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
filter(flights, origin == "JFK", dest == "SEA") %>% 
  summarize(
    avg_air_time = mean(time_gained_or_lost, na.rm = TRUE),
    max_air_time = max(time_gained_or_lost, na.rm = TRUE),
    min_air_tie = min(time_gained_or_lost, na.rm = TRUE)
  )

