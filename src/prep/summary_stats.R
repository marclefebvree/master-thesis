library("table1")

df_clean <- read.csv("data/df_clean.csv")

# Table 3 data

table1::table1(~owners + user_rating + expert_rating + game_mode + d_publisher + price + release_date, data = df_clean)

table(df_clean$d_publisher)

table(df_clean$game_mode)

# Table 4 data

table1::table1(~owners + user_rating + expert_rating | game_mode, data = df_clean)

table1::table1(~owners + user_rating + expert_rating | d_publisher, data = df_clean)

