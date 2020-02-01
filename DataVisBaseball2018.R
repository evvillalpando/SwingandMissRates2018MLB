library(dplyr)
library(tidyr)
library(ggplot2)
library(ggimage)



# Create a tibble containing the swing and miss rates of each team, by pitch type (offspeed/fastball)
SwingStrikeData <- as_tibble(RegularSeasonPitchData2018) %>%
  select(Team, des, pitch_type)%>%
  mutate(PitchType = ifelse(pitch_type %in% c("FA", "FF", "FT","FC","FS","SI","SF"), "Fastball","Offspeed"))%>%
  group_by(Team,PitchType)%>%
  summarize(SwingStrike = sum(des=="Swinging Strike")/n() *100)%>%
  arrange(SwingStrike)

# COuldn't figure out how to make the % given a numeric data type within the piping above
SwingStrikeData <- as.numeric(SwingStrikePercByType$SwingStrike)

# Adds a column to the data frame with an image of the team logo, used for plotting below

TeamLogos <- data.frame("Team" = c('Athletics', 'Cardinals','Astros','Pirates','Phillies','Twins', 
                                   'Braves','Mets','Rockies','Angels','White Sox', 'Royals', 'Padres',
                                   'Blue Jays', 'Nationals', 'Reds', 'Tigers', 'Marlins', 'Indians',
                                   'Yankees', 'Rangers', 'Cubs', 'Mariners', 'Giants', 'Rays', 'Orioles',
                                   'Brewers', 'D-backs', 'Dodgers', 'Red Sox', 'Marlins'),
                        "Logo" = c('https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/oakland_athletics.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/st_louis_cardinals_1998-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/houston_astros_2013-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/pittsburgh_pirates_2015-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2018/12/philadelphia_phillies_2019-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/minnesota_twins_2010-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2018/01/atlanta_braves_1987-pres_a.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/new_york_mets.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/colorado_rockies_2017-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/los_angeles_angels_2005-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/chicago_white_sox_1991-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2019/02/kansas_city_royals_2019-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2019/11/san_diego_padres_2020-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/toronto_blue_jays.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/washington_nationals.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/cincinnati_reds_2013-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2018/03/detroit_tigers_2016-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2018/11/miami_marlins_2019-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/cleveland_indians_2014-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2018/03/new_york_yankees_1968-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/texas_rangers.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/chicago_cubs.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_primary/seattle_mariners.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/san_francisco_giants_2000-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2019/03/tampa_bay_rays_2019-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2019/02/baltimore_orioles_2019-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2019/11/milwaukee_brewers_2020-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/arizona_diamondbacks_2012-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2016/SLH/mlb_alternate/los_angeles_dodgers_2012-present_a.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2017/12/boston_red_sox_2009-pres.png',
                                   'https://sportslogohistory.com/wp-content/uploads/2018/11/miami_marlins_2019-pres.png'))

DataWithLogo <- SwingStrikeData %>%
  left_join(TeamLogos, by = c("Team" = "Team"))
DataWithLogo$Logo <- as.character(DataWithLogo$Logo)


ggplot(DataWithLogo, aes(x = reorder(Team, -SwingStrike), y = SwingStrike, col = PitchType)) +geom_point() +coord_flip() + theme_minimal()

##
testplot <- ggplot(SwingStrikeData, aes(x = reorder(Team, -SwingStrike), y = SwingStrike)) +
  theme_minimal() +
  geom_image(aes(image=Logo), size = 0.04) +
  geom_hline(yintercept = mean(offspeedData$SwingStrike), color = "blue", size =2, alpha =.25, linetype = "dashed") +
  xlab("Teams") + ylab("Swinging and Miss %") +
  labs(title = "Swing and Miss Rates by Team, 2018 Season",
       subtitle = "Data courtesy: MLB Advanced Media, using the mlbgameday package")

testplot + theme(panel.grid.major.x=element_blank()) + scale_x_discrete(breaks = NULL) + 
  geom_text(aes(label = paste0(round(offspeedData$SwingStrike, digits = 1), "%")), size = 3.5, vjust=-3.2, check_overlap = TRUE) +
  scale_y_continuous(limits = c(11,15))



                   