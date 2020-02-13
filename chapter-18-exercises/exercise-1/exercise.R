# load relevant libraries
library("httr")
library("jsonlite")
library("dplyr")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("api_key.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Parasite"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
base_uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/seach.json"
uri <- paste0(base_uri, resource)
response <- GET(
  uri,
  query = list(
    "api-key" = api_key,
    query = movie_name
  )
)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response_text <- content(response, type = "text")
response_data <- fromJSON(response_text)

# What kind of data structure did this produce? A data frame? A list?
class(response_data)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(response_data)
names(response_data$results)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(response_data$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
headline <- reviews %>% select(headline)
short_summary <- reviews %>% select(summary_short)
link <- reviews %>% select(link.url)

# Create a list of the three pieces of information from above. 
# Print out the list.
info <- list(headline = headline, summary = short_summary, link = link)
print(info)
