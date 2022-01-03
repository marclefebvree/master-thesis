# Regression tests

## Add additional necessary computations of data (not all are used)

clean_test <- df_clean

clean_test$d_price_free <- ifelse(df_clean$price == 0, 1, 0)
clean_test$d_price_low <- ifelse(clean_test$price >= 0.01& clean_test$price <= 5, 1, 0)
clean_test$d_price_mid <- ifelse(clean_test$price >= 5.01& clean_test$price <= 10, 1, 0)
clean_test$d_price_high <- ifelse(clean_test$price > 10.01, 1, 0)
clean_test$d_release_old <- ifelse(clean_test$release_date <= 2010, 1, 0)
clean_test$d_release_mid <- ifelse(clean_test$release_date >= 2011& clean_test$release_date <= 2016, 1, 0)
clean_test$d_release_recent <- ifelse(clean_test$release_date >= 2017, 1, 0)
clean_test$log_owners <- log(clean_test$owners)
clean_test$log_user <- log(clean_test$user_rating)
clean_test$adj_owners <- clean_test$owners / 10
clean_test$scale_expert <- scale(clean_test$expert_rating)
clean_test$scale_user <- scale(clean_test$user_rating)
clean_test$scale_mode <- scale(clean_test$game_mode)
clean_test$scale_publisher <- scale(clean_test$d_publisher)
clean_test$scale_price <- scale(clean_test$d_price_free)
clean_test$scale_old <- scale(clean_test$d_release_old)
clean_test$scale_mid <- scale(clean_test$d_release_mid)
clean_test$scale_new <- scale(clean_test$d_release_recent)

## Test different models ()

library("fixest")
library("modelsummary")

fls_1 <- feols(log(owners) ~ expert_rating + user_rating + d_publisher + game_mode + d_price_free + d_release_old + d_release_mid + d_release_recent, data = clean_test, se = "hetero")

fls_2 <- feols(log(owners) ~ expert_rating + user_rating + game_mode*expert_rating + game_mode*user_rating + d_publisher + d_price_free + d_release_old + d_release_mid + d_release_recent, data = clean_test, se = "hetero")

fls_3 <- feols(log(owners) ~ expert_rating + user_rating + d_publisher*expert_rating + d_publisher*user_rating + game_mode + d_price_free + d_release_old + d_release_mid + d_release_recent, data = clean_test, se = "hetero")

fls_4 <- feols(log(owners) ~ scale_expert + scale_user + scale_mode*scale_user + scale_mode*scale_expert + scale_publisher*scale_user + scale_publisher*scale_expert + scale_publisher + scale_mode + scale_price + scale_old + scale_mid, data = clean_test, se = "hetero")

## Compute model summary of final model

msummary(list("OLS" = fls_4),
         coef_rename = c("scale_expert" = "Expert rating",
                         "scale_user" = "User rating",
                         "scale_expert:scale_mode" = "Expert rating x Game mode",
                         "scale_user:scale_mode" = "User rating x Game mode",
                         "scale_expert:scale_publisher" = "Expert rating x Publisher",
                         "scale_user:scale_publisher" = "User rating x Publisher"),
         gof_omit = c("R2 Within|R2 Pseudo|Log.Lik.|AIC|BIC"),
         statistic = "{std.error} ({p.value})", stars = TRUE)
         #output = "gen/analysis/output/regression_table.png")



