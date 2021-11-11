library(dplyr)
library(tidyr)

# Steam dataset

steam_ds <- read.csv('steam.csv')

steam_ds <- steam_ds[!(steam_ds$average_playtime == '0'),]

steam_ds$positive_ratings <- as.integer(steam_ds$positive_ratings)
steam_ds$negative_ratings <- as.integer(steam_ds$negative_ratings)

steam_ds$total_ratings <- steam_ds$positive_ratings + steam_ds$negative_ratings

steam_ds <- steam_ds[!(steam_ds$total_ratings < 1000),]

steam_ds$user_rating <- ( steam_ds$positive_ratings / (steam_ds$positive_ratings + steam_ds$negative_ratings) )

steam_ds <- within(steam_ds, rm('english', 'developer', 'platforms', 'required_age', 'genres', 'steamspy_tags', 'achievements', 'owners', 'price'))

steam_ds <- steam_ds %>% 
  mutate(id = appid )
  
#game_id <- data.frame(steam_ds$appid)

#write.csv(game_id, file = 'game_id.csv')

metascore <- read.csv('metascore.csv')
game_url <- read.csv('game_url.csv')

df_merged <- merge(game_url, metascore, by = 'full_url')
df_merged2 <- merge(df_merged, steam_ds, by = 'id')

df_merged2 <- df_merged2 %>%
  drop_na(metascore) %>% 
  mutate(expert_rating = metascore)

table(df_merged2$publisher)

df_merged2 <- within(df_merged2, rm('full_url', 'base_url', 'metascore', 'appid', 'positive_ratings', 'negative_ratings', 'total_ratings', 'average_playtime', 'median_playtime'))

df_merged2$expert_rating <- gsub("%", "", df_merged2$expert_rating)

df_merged2$expert_rating <- trimws(df_merged2$expert_rating, which = c("both"))

df_merged2$expert_rating <- as.numeric(df_merged2$expert_rating)

df_merged2$expert_rating <- df_merged2$expert_rating / 100

table(df_merged2$categories)

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


df_merged2$game_mode <- ifelse(df_merged2$categories == "Single-player", 1, 0)

df_merged2 <- df_merged2 %>% mutate_at(vars(user_rating), funs(round(., 2)))

write.csv(df_merged2, file = "df_merged2.csv")

table(df_merged2$game_mode)

sapply(df_merged2, mode)
