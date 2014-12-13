shinyUI(fluidPage(
  titlePanel("Temperature & Runoff - Time Series"),
  
  helpText("Hourly temperature data was collected from weather stations on the Merced and Tuolumne watersheds, 
           and monthly average runoff levels were collected from USGS gauges. Each of the stations can be seen 
           on the map below."),
  
  img(src = "sitemap.png", height = 400, width = 400), 
  
  helpText(" "), 
   
  helpText("Data from no later than the year 2000 was used from each site. Our goal was to examine the two data sets
            for any respective trending and/or correlation between temperature and runoff levels. We did so by 
           modeling the data sets as time series, and looking at the Pearson correlation coefficient using R."), 
  
  helpText(" "),
  helpText("As you can see below, none of the data shows any obvious trends. Further analysis would be necessary to 
           to determine if either data is displaying subtle trending."),
  helpText(" "),
  helpText("NOTE: No temporally appropriate runoff data was found for the 'Crane Flat' and 'Gaylor Meadow' 
               sites."), 
  sidebarLayout(
    
    sidebarPanel(position="left", 
      selectInput("var", 
                label = "Selected Site:",
                choices = c("Crane Flat", "Jersey Dale",
                            "Metcalf Gap", "Gaylor Meadow", 
                            "White Wolf", "Mt. Elizabeth"),
                selected = "Crane Flat")),   
    
      mainPanel(position="right", 
        tabsetPanel(
          tabPanel("Temperature", plotOutput("tempseries")),
          tabPanel("Run-off", plotOutput("runseries"))
          )
      )),  
    
      helpText("The resulting p-values, correlation coefficients, and discussions of such are as follows:"), 
      helpText("JERSEY DALE ~  p-value= 3.28e-07, cor = 0.4315945"),
      helpText(" The low p-value gives a strong indication that the null hypothesis is not true, and that 
               there is a correlation between the two variables. The correlation coefficient of 0.460339 
               indicates a strong positive correlation between temperature and run-off."),
      helpText("METCALF GAP ~  p-value= 1.434e-12, cor = -0.7239012"), 
      helpText(" The correlation test for Metacalf Gap yields an even lower p-value, further rejecting 
               the null hypothesis of no correlation, and a VERY strong negative correlation between runoff and 
               temperature. This is most likely the result of a mis-handling of the data and is not a valid result."),
      helpText("WHITE WOLF ~  p-value= 0.128, cor = 0.1715914"), 
      helpText(" The p-value given here is greater than 0.1, thus there is no presumption against the null 
               hypothesis; and it can be presumed that, for this site, temperature and runoff are not correlated."),
      helpText("MT. ELIZABETH ~  p-value= 1.312e-09, cor = 0.460339"), 
      helpText(" Finally, we see again a low p-value and a high correlation coefficient; indicating that the runoff 
               and temperature are much more likely to be correlated at the sites for Mt. Elizabeth."),
      helpText(" ") 
    
))
