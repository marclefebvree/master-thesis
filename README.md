# How Review Ratings Influence Sales on Steam
## A study in the Video Game Industry
### Abstract
The video game industry has grown immensely. Additionally, there has been a surge of online reviews and consumers that consult online reviews in decision making. Due to this, it is important to understand the influence that online reviews have on the sale of video games. Although several studies have examined the effect of online reviews on the sale of video games, all of these studies were focused on the effect of expert- or user review ratings on console game sales. Therefore, this study investigates a new context, namely the effect of expert- and user review ratings on the sale of PC games. In addition, this study develops hypotheses on how these effects may be moderated by video game characteristics.
This research is applied on Steam, which is a platform through which video games for PC can be purchased. The number of downloads for a given game is used as the dependent variable, and expert- and user review rating are used as independent variables. Furthermore, the moderating variables are game mode (i.e. multi-player or single-player) and publisher (i.e. major publisher or minor publisher). In order to conduct this research, data on video games was collected from multiple online sources. After collection, the data was processed resulting in a clean and rich dataset of 1,203 video games. To test the hypotheses, the clean dataset was regressed using an OLS regression.
The results show that expert- and user review rating both have a positive effect on the number of downloads on Steam. However, the effect of expert review ratings is larger than that of user review ratings. Therefore, expert review ratings carry more importance for video game downloads than user review ratings. Moreover, game mode has been found to moderate the effect of user review rating on the number of downloads. If a video game has multi-player functionalities, the effect of user review rating on the number of downloads increases. Furthermore, publisher has been found to moderate the effect of expert review rating on the number of downloads. If a video game is published by a major publisher, the effect of expert review rating on the number of downloads increases.
The findings suggest that video game publishers releasing PC games should take both expert- and user review ratings into account, due to their significant effect on sales related outcomes. In addition, managers of major publishers should pay attention to practices that may improve expert ratings. This is due to the fact that effect of expert ratings on sales is strengthened when a game is released by a major publisher. Also, publishers that release multi-player games should lay emphasis on the improvement of user ratings. This is because the effect of user ratings on sales is strengthened when a game is multi-player.

### GitHub structure
├── README.md 
├──.gitignore 
├── doc 
│   └── thesis_marclefebvre_2040052 
├── data 
│   ├── d_publishers.csv 
│   ├── df_merged2.csv 
│   ├── game_id.csv 
│   ├── game_url.csv 
│   ├── metascore.csv 
│   ├── publishers.csv 
│   ├── results.csv 
│   └── steam.csv 
├── gen 
│   ├── analysis 
│   │   └─ output 
│   │     └── regression_table.png 
│   └─── data-preparation 
│       └─ output 
│         └── df_clean.csv 
└── src 
    ├── collect 
    │   ├── SteamDB.ipynb 
    │   └── steamspy.ipynb 
    ├── preparation 
    │   ├── summary_stats.R 
    │   └── clean.R 
    ├── analysis 
    │   └── regression.R 
    └── .DS_Store
