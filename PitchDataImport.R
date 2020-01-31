library(mlbgameday)
library(doParallel)
library(DBI)
library(RSQLite)
library(dplyr)
library(tidyr)

# First we need to register our parallel cluster.
no_cores <- detectCores() - 1
cl <- makeCluster(no_cores)  
registerDoParallel(cl)

# Vector of all team names to search using mlbgameday's import function
teamstr <- c('Athletics', 'Cardinals','Astros','Pirates','Phillies','Twins', 
             'Braves','Mets','Rockies','Angels','White Sox', 'Royals', 'Padres',
             'Blue Jays', 'Nationals', 'Reds', 'Tigers', 'Marlins', 'Indians',
             'Yankees', 'Rangers', 'Cubs', 'Mariners', 'Giants', 'Rays', 'Orioles',
             'Brewers', 'D-backs', 'Dodgers', 'Red Sox', 'Marlins')


# Collect a tibble of all regular season pitch data for each team in provided vector above using the search_gids() and get_payload() functions
teamer <- function(x, yearstart, yearend, gameType, homeOnly){
  a <- c()
  for (i in 1:length(x)){
    gameIDz <- search_gids(team = x[i], start = yearstart, end = yearend, game_type = gameType, home_only = homeOnly)
    a[i] <- get_payload(game_ids = gameIDz, dataset = "inning_all")$pitch
  }
  return(a)
}
# Call the function & store the output of teamer into a list of lists
listofTeams <- teamer(teamstr, yearstart = "2018-01-30", yearend = "2018-12-30", gameType = "r", homeOnly = TRUE)

# Bind the list of teams by team
reduction <- listofTeams %>%
  bind_rows(.id = "Team")

# Calculates the swing strike percentage, by pitch time, by team.
SwingStrikePerc <- reduction %>%
  select(Team, des, pitch_type)
  group_by(Team,pitch_type)%>%
  summarize(SwingStrike = sum(des=="Swinging Strike")/n() *100)%>%
  arrange(SwingStrike)
