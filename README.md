I wanted to explore swing and miss rates and facet them by pitch type for each team in the MLB. This was merely exploratory and to exercise using the dplyr package as well as ggimage. Each file included in this repository is listed below.
**NOTE** The only file missing here is the .csv I created, but it's about 450 MB large. Turns out, there are __a lot__ of pitches thrown in the regular season! Feel free to email me @ evasquez1192@gmail.com if you'd like a subset of the CSV.

## PitchDataImport.R
[PitchDataImport.R](https://github.com/evvillalpando/SwingandMissRates2018MLB/blob/master/PitchDataImport.R) is a script containing all the functions I created to import the data—that's it.

## DataVisBaseball2018.R
[DataVisBaseball2018.R](https://github.com/evvillalpando/SwingandMissRates2018MLB/blob/master/DataVisBaseball2018.R) is a script used to experiment with the ggplot and ggimage packages, and ultimately visualize the swing and miss rates by team for the 2018 season

## Rplot07.jpg
[Visualization](https://raw.githubusercontent.com/evvillalpando/SwingandMissRates2018MLB/master/Rplot07.jpeg) of the data for swing and miss rates in 2018, at home, on fastballs only. The DataVis script linked above can be manipulated to show the data for offspeed pitches as well, but it more or less paints the same picture.

