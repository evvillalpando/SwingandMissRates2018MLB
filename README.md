My initial reason for starting this project was to see if the Astros and Red Sox cheating scandal manifested itself in regular season games, but the data presented here is inconclusive (there are far better metrics for showing the effects of their cheating; this was mostly exploratory and a means to practice importing, cleaning, and visualizing real world data). In any case, the MLB's investigation has concluded. Each file included in this repository is listed below.
**NOTE** The only file missing here is the .csv I created, but it's about 450 MB large. Turns out, there are __a lot__ of pitches thrown in the regular season!

## PitchDataImport.R
[PitchDataImport.R](https://github.com/evvillalpando/SwingandMissRates2018MLB/blob/master/PitchDataImport.R) is a script containing all the functions I created to import the data—that's it.

## DataVisBaseball2018.R
[DataVisBaseball2018.R](https://github.com/evvillalpando/SwingandMissRates2018MLB/blob/master/DataVisBaseball2018.R) is a script used to experiment with the ggplot and ggimage packages, and ultimately visualize the swing and miss rates by team for the 2018 season

## Graph.jpg
[Visualization](https://raw.githubusercontent.com/evvillalpando/SwingandMissRates2018MLB/master/Rplot07.jpeg) of the data for swing and miss rates in 2018, at home, on fastballs only. The DataVis script linked above can be manipulated to show the data for offspeed pitches as well, but it more or less paints the same picture.

