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
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── thesis_marclefebvre_2040052 
├── data 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── d_publishers.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── df_merged2.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── game_id.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── game_url.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── metascore.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── publishers.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── results.csv 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── steam.csv 
├── gen 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── analysis 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;└─ output 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── regression_table.png 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─── data-preparation 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; └─ output 
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; └── df_clean.csv 
└── src 
&nbsp;&nbsp;&nbsp;&nbsp;├── collect 
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;├── SteamDB.ipynb 
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;└── steamspy.ipynb 
&nbsp;&nbsp;&nbsp;&nbsp;├── preparation 
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;├── summary_stats.R 
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;└── clean.R 
&nbsp;&nbsp;&nbsp;&nbsp;├── analysis 
&nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;└── regression.R 
&nbsp;&nbsp;&nbsp;&nbsp;└── .DS_Store
