
load("G:/Shiny Tutorial/runoff-app/MCD_Crane_Flats_01_13.Rda")
load("G:/Shiny Tutorial/runoff-app/MCD_Jersey_Dale_02_13.Rda")
load("G:/Shiny Tutorial/runoff-app/MCD_Metcalf_Gap_01_13.Rda")
load("G:/Shiny Tutorial/runoff-app/TU_Gaylord_Meadows_01_11.Rda")
load("G:/Shiny Tutorial/runoff-app/TU_Mt_Elizabeth_01_13.Rda")
load("G:/Shiny Tutorial/runoff-app/TU_White_Wolf_01_13.Rda")




#Temperature Data


CFmeans = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=CFlats, mean)
CF.temp.mo.mean = ts(as.vector(tapply(CFmeans$Temp,list(CFmeans$monthYr), mean)), frequency=12)

#JERSEY DALE
JDale<-MCD_Jersey_Dale_02_13
#Aggregate to have all info combined into monthly means, medians
JDmonthmeans = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=JDale, mean)
JDmonthmeds = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=JDale, median)

JD.temp.mo.mean = ts(as.vector(tapply(JDmonthmeans$Temp,list(JDmonthmeans$monthYr), mean)), frequency=12)

#METACALF GAP
MCGap<-MCD_Metcalf_Gap_01_13
#SiteTemp
MCGapmeans = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=MCGap, mean)
MCGapmeds = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=MCGap, median)

MG.temp.mo.mean = ts(as.vector(tapply(MCGapmeans$Temp,list(MCGapmeans$monthYr), mean)), frequency=12)

#GAYLOR MEADOW
Gaylord<-TU_Gaylord_Meadows_01_11
Gaylordmeans = aggregate(cbind(Speed,Direc,Temp,Humidty) ~ monthYr, data=Gaylord, mean)
Gaylordmeds = aggregate(cbind(Speed,Direc,Temp,Humidty) ~ monthYr, data=Gaylord, median)
GM.temp.mo.mean = ts(as.vector(tapply(Gaylordmeans$Temp,list(Gaylordmeans$monthYr), mean)), frequency=12)

#WHITE WOLF
WWolf<- TU_White_Wolf_01_13
WWolfmeans = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=WWolf, mean)
WWolfmeds = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=WWolf, median)
WW.temp.mo.mean = ts(as.vector(tapply(WWolfmeans$Temp,list(WWolfmeans$monthYr), mean)), frequency=12)

#MT. ELIZABETH
MtEli<- TU_Mt_Elizabeth_01_13
MtElimeans = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=MtEli, mean)
MtElimeds = aggregate(cbind(Speed,Direc,Temp,Humidty,Rad.) ~ monthYr, data=MtEli, median)
ME.temp.mo.mean = ts(as.vector(tapply(MtElimeans$Temp,list(MtElimeans$monthYr), mean)), frequency=12)





#Run-off data

jd_monthly <- read.table("G:/ENVE Project/Project Data/Discharge/jd.monthly", header=TRUE, quote="\"")

#Remove top row (non-applicable values)
jd_mon = subset(jd_monthly, agency_cd!="5s")
#subset for years also in weather station data
jd_mon$year_nu=as.character(jd_mon$year_nu)
jd_mon$year_nu=as.numeric(jd_mon$year_nu)
jd_mon = jd_mon[jd_mon$year_nu>2001,]

#Convert yr_month to posix item 
jd_mon$yr_month=paste(jd_mon$year_nu, jd_mon$month_nu, "01", sep="-")
jd_mon$yr_month = as.POSIXct(jd_mon$yr_month,format="%Y-%m-%d")
#convert monthly mean value runoff from character to numeric
jd_mon$mean_va=as.numeric(jd_mon$mean_va)

#Metacalf Gap
MCGap <- read.table("C:/Users/Shelby/Downloads/monthly (3)", header=TRUE, quote="\"")
mcg_mon = subset(MCGap, agency_cd!="5s")

mcg_mon$yr_month=paste(mcg_mon$year_nu, mcg_mon$month_nu, "01", sep="-")
mcg_mon$yr_month = as.POSIXct(mcg_mon$yr_month,format="%Y-%m-%d")
mcg_mon$monthYr=strftime(mcg_mon$yr_month, format="%Y/%m")

mcg_mon$mean_va=as.numeric(mcg_mon$mean_va)

#White Wolf
ww <- read.table("G:/ENVE Project/Project Data/Discharge/ww_monthly", header=TRUE, quote="\"")
ww_mon = subset(ww, agency_cd!="5s")
ww_mon$year_nu=as.character(ww_mon$year_nu)
ww_mon$year_nu=as.numeric(ww_mon$year_nu)
ww_mon = ww_mon[ww_mon$year_nu>1999,]

ww_mon$yr_month=paste(ww_mon$year_nu, ww_mon$month_nu, "01", sep="-")
ww_mon$yr_month = as.POSIXct(ww_mon$yr_month,format="%Y-%m-%d")

ww_mon$mean_va=as.numeric(ww_mon$mean_va)

#Mt. Elizabeth
me <- read.table("G:/ENVE Project/Project Data/Discharge/me_monthly", header=TRUE, quote="\"")
me_mon = subset(me, agency_cd!="5s")
me_mon$year_nu=as.character(me_mon$year_nu)
me_mon$year_nu=as.numeric(me_mon$year_nu)
me_mon = me_mon[me_mon$year_nu>1999,]

me_mon$yr_month=paste(me_mon$year_nu, me_mon$month_nu, "01", sep="-")
me_mon$yr_month = as.POSIXct(me_mon$yr_month,format="%Y-%m-%d")

me_mon$mean_va=as.numeric(me_mon$mean_va)

#Creating RUnoff Time Series Objects

JD.runoff.mo.mean = ts(as.vector(jd_mon$mean_va), frequency=12)
MG.runoff.mo.mean = ts(as.vector(mcg_mon$mean_va), frequency=12)
WW.runoff.mo.mean = ts(as.vector(ww_mon$mean_va), frequency=12)
ME.runoff.mo.mean = ts(as.vector(me_mon$mean_va), frequency=12)


#APP CODE

shinyServer(
  function(input, output) {
    output$tempseries <- renderPlot({
      
      x <- switch(input$var,
              "Crane Flat"= window(CF.temp.mo.mean), 
              "Jersey Dale"= window(JD.temp.mo.mean), 
              "Metcalf Gap"= window(MG.temp.mo.mean), 
              "Gaylor Meadow"= window(GM.temp.mo.mean), 
              "White Wolf"= window(WW.temp.mo.mean), 
              "Mt. Elizabeth"= window(ME.temp.mo.mean))
      
      main <- switch(input$var,
                  "Crane Flat"= "Crane Flat", 
                  "Jersey Dale"= "Jersey Dale", 
                  "Metcalf Gap"= "Metcalf Gap", 
                  "Gaylor Meadow"= "Gaylor Meadow", 
                  "White Wolf"= "White Wolf", 
                  "Mt. Elizabeth"="Mt. Elizabeth")
      
      plot.ts(x=x, main=main, xlab="Time(Years)", ylab="Temperature(C)")
    })
    output$runseries <- renderPlot({
      
      x <- switch(input$var,
                  "Jersey Dale"= window(JD.runoff.mo.mean), 
                  "Metcalf Gap"= window(MG.runoff.mo.mean),  
                  "White Wolf"= window(WW.runoff.mo.mean), 
                  "Mt. Elizabeth"= window(ME.runoff.mo.mean))
      
      main <- switch(input$var,
                     "Jersey Dale"= "Jersey Dale", 
                     "Metcalf Gap"= "Metcalf Gap",  
                     "White Wolf"= "White Wolf", 
                     "Mt. Elizabeth"="Mt. Elizabeth")
      
      plot.ts(x=x, main=main, xlab="Time(Years)", ylab="Run-off(cfs)")
    })
    
    })
