# Load libraries

library(dplyr)
library(tidyr)


# Load steam dataset

steam_ds <- read.csv('data/steam.csv')


# Remove games with no playing time

steam_ds <- steam_ds[!(steam_ds$average_playtime == '0'),]


# Change datatype of positive and negative ratings

steam_ds$positive_ratings <- as.integer(steam_ds$positive_ratings)
steam_ds$negative_ratings <- as.integer(steam_ds$negative_ratings)


# Remove games with less than 1000 total ratings

steam_ds$total_ratings <- steam_ds$positive_ratings + steam_ds$negative_ratings
steam_ds <- steam_ds[!(steam_ds$total_ratings < 1000),]


# Create variable user rating

steam_ds$user_rating <- ( steam_ds$positive_ratings / (steam_ds$positive_ratings + steam_ds$negative_ratings) )


# Remove unnecessary columns

steam_ds <- within(steam_ds, rm('english', 'developer', 'platforms', 'required_age', 'genres', 'steamspy_tags', 'achievements', 'owners'))


# Extract game id's for webscrapers

steam_ds <- steam_ds %>% 
  mutate(id = appid )
  
game_id <- data.frame(steam_ds$appid)

write.csv(game_id, file = 'data/game_id.csv')


# Import metascores and urls and merge with full dataset

metascore <- read.csv('data/metascore.csv')
game_url <- read.csv('data/game_url.csv')

df_merged <- merge(game_url, metascore, by = 'full_url')
df_merged2 <- merge(df_merged, steam_ds, by = 'id')


# Drop NAs and adjust metascore column name to expert_rating

df_merged2 <- df_merged2 %>%
  drop_na(metascore) %>% 
  mutate(expert_rating = metascore)


# Remove unnecessary columns

df_merged2 <- within(df_merged2, rm('full_url', 'base_url', 'metascore', 'appid', 'positive_ratings', 'negative_ratings', 'total_ratings', 'average_playtime', 'median_playtime'))


# Create expert rating variable as percentage

df_merged2$expert_rating <- gsub("%", "", df_merged2$expert_rating)
df_merged2$expert_rating <- trimws(df_merged2$expert_rating, which = c("both"))
df_merged2$expert_rating <- as.numeric(df_merged2$expert_rating)
df_merged2$expert_rating <- df_merged2$expert_rating / 100


# Remove unnecessary categories

df_merged2$categories <- gsub("Steam Achievements", "", df_merged2$categories)
df_merged2$categories <- gsub("Steam Trading Cards", "", df_merged2$categories)
df_merged2$categories <- gsub("Captions available", "", df_merged2$categories)
df_merged2$categories <- gsub("Partial Controller Support", "", df_merged2$categories)
df_merged2$categories <- gsub("Steam Leaderboards", "", df_merged2$categories)
df_merged2$categories <- gsub("Steam Cloud", "", df_merged2$categories)
df_merged2$categories <- gsub("Steam Workshop", "", df_merged2$categories)
df_merged2$categories <- gsub("Includes level editor", "", df_merged2$categories)
df_merged2$categories <- gsub("Commentary available", "", df_merged2$categories)
df_merged2$categories <- gsub("Stats", "", df_merged2$categories)
df_merged2$categories <- gsub("SteamVR Collectibles", "", df_merged2$categories)
df_merged2$categories <- gsub("VR Support", "", df_merged2$categories)
df_merged2$categories <- gsub("Full controller support", "", df_merged2$categories)
df_merged2$categories <- gsub("In-App Purchases", "", df_merged2$categories)
df_merged2$categories <- gsub("Valve Anti-Cheat enabled", "", df_merged2$categories)
df_merged2$categories <- gsub("Online Co-op", "", df_merged2$categories)
df_merged2$categories <- gsub("MMO", "", df_merged2$categories)
df_merged2$categories <- gsub("Shared/Split Screen", "", df_merged2$categories)
df_merged2$categories <- gsub("Local Multi-player", "", df_merged2$categories)
df_merged2$categories <- gsub("Cross-Platform", "", df_merged2$categories)
df_merged2$categories <- gsub("Steam Turn Notifications", "", df_merged2$categories)
df_merged2$categories <- gsub("Includes Source SDK", "", df_merged2$categories)
df_merged2$categories <- gsub("Co-op", "", df_merged2$categories)
df_merged2$categories <- gsub(";", " ", df_merged2$categories)
df_merged2$categories <- trimws(df_merged2$categories, which = c("both"))
df_merged2$publisher <- trimws(df_merged2$publisher, which = c("both"))


# Compute dummy variable for game mode

df_merged2$game_mode <- ifelse(df_merged2$categories == "Single-player", 1, 0)


# Round of user_rating to two decimals

df_merged2 <- df_merged2 %>% 
  mutate_at(vars(user_rating), funs(round(., 2)))


# Save df_merged2

write.csv(df_merged2, file = "df_merged2.csv")


# Create dataset in order to systematically create dummy variable for publisher

publishers_overview <- as.data.frame(df_merged2$publisher)
publishers_overview <- rename(publishers_overview, 'publisher' = 'df_merged2$publisher')
publishers_overview$publisher <- trimws(publishers_overview$publisher, which = c('both'))

publishers_overview <- publishers_overview %>% 
  group_by(publisher)
  
publishers_overview <- publishers_overview[!duplicated(publishers_overview$publisher),]

write.csv(publishers_overview, file = "data/publishers.csv")


# Merge owners with df_merged 2

results <- read.csv("data/results.csv")

df_merged3 <- merge(results, df_merged2, by = "id")


# Create final clean dataset

d_publisher <- read.csv("data/d_publishers.csv")

df_clean <- merge(df_merged3, d_publisher, by = "publisher")

df_clean <- rename(df_clean, "delete" = "...1")
drops <- c("delete")
df_clean <- df_clean[, !(names(df_clean) %in% drops)]

df_clean$release_date <- sub("\\-.*","\\",df_clean$release_date)
df_clean$release_date <- as.numeric(df_clean$release_date)

write.csv(df_clean, file = "data/df_clean.csv")

#library("sjPlot")
#library("sjmisc")
#library("sjlabelled")

#m1 <- lm(owners ~ expert_rating + user_rating, data = df_clean)
#m2 <- lm(owners ~ expert_rating + user_rating + game_mode*user_rating + game_mode*expert_rating + d_publisher*user_rating + d_publisher*expert_rating, data = df_clean)
m3 <- lm(owners ~ expert_rating + user_rating + game_mode*user_rating + game_mode*expert_rating + d_publisher*user_rating + d_publisher*expert_rating + release_date + price, data = df_clean)

summary(lm(owners ~ expert_rating + user_rating + game_mode*user_rating + game_mode*expert_rating + d_publisher*user_rating + d_publisher*expert_rating + release_date + price, data = df_clean))

tab_model(m3)
