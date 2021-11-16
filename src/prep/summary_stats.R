library("table1")

df_clean <- read.csv("data/df_clean.csv")

table1::table1(~owners + user_rating + expert_rating + game_mode + d_publisher, data = df_clean)

table1::table1(~owners + user_rating + expert_rating | game_mode, data = df_clean)

table(df_clean$d_publisher)

table(df_clean$game_mode)
