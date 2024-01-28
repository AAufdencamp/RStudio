?read.csv()

#method 1: select file manually
stats<-read.csv(file.choose())
stats


#method 2: set working directory and Read Data
getwd()

#Windows:
setwd("C:\\Users\\aaufdencamp\\Desktop\\R_bootcamp\\5")

getwd()

#rm(stats)
stats <- read.csv("P2-Demographic-Data.csv")
stats

#--------------Exploring Data

nrow(stats)
#Imported 195 rows

ncol(stats)
head(stats, n = 10)
tail(stats, n = 8)
str(stats)
summary(stats)

#-----------Using the $ sign
stats
head(stats)
stats[3,3]
stats[3,"Birth.rate"]
stats$Internet.users  #do same thing
stats[, "Internet.users"] #do same thing
stats$Internet.users[2]
stats[10,4]
stats[10,]
stats[85,]
stats$Internet.users[c(1,3,4)]
stats$Internet.users
data.frame(stats$Internet.users[c(1,3,4)])
is.data.frame(data.frame(stats$Internet.users[c(1,3,4)]))
stats[,1,drop = F]
is.data.frame(stats[,1,drop = F])
# $ is used a lot for dataframes
str(stats)

stats

#what are all the factors' levels?
levels(stats[,5, drop = F])
?levels()
x<-stats[,5, drop = F]
is.data.frame(x)
x
levels(stats[,1, drop=F])
stats[,1, drop=F]
stats[,5, drop = F]
levels(stats[,1, drop=F])
is.data.frame(stats[,1, drop=F])
#this is not working to access the levels because
#Income.Group objects are listed as chr, so that
#must be why I get NULL.

#----------Basic operations w a DataFrame

stats[1:10,] #subsetting
stats[3:9,]
stats[c(4,100),] #get rows 4 and 100 and all columns
#R preserves the row labels of the DF. 
#remember how square brackets work
stats[1,]
is.data.frame(stats[1,])
#in a matrix if you return 1 row the default 
#drops the 2D of a matrix and returns a vector
#unless you set drop = FALSE.
#In a DataFrame if you return 1 row the resulting
#result is still recognized as a DF

stats[,1]
is.data.frame(stats[,1])
stats[,1, drop = F]
is.data.frame(stats[,1, drop = F])
#HOWEVER, for a DF if you subset 1 column the 
#dimensionality reduction R does by default returns
#a vector! and in the case of subsetting just
# a single column to get a DF use drop = F

#multiply columns
head(stats)
 x<-stats$Internet.users * stats$Birth.rate
 stats$Internet.users + stats$Birth.rate
is.data.frame(x)
 #add a columns
 head(stats)
 stats$MyCalc <-  stats$Internet.users * stats$Birth.rate
 head(stats)
 
 #test know how
 stats$xyz<-1:5
head(stats, n=10) 
 #here we inserted a new column into DF stats
#where the sequence is just 1, 2, 3, 4, 5.
#But the DF stats has 195 rows. so R recycles
#the sequence 1:5 to fill in the column through 
#row 195. NOTE: for R to recycle a vector its 
#length must be a multiple of the length of the object
#it is "filling" up. in this case 5 is a multiple of
#195
str(stats)

#to remove a column from a DF subset it and 
#assign it to NULL

head(stats)
stats$MyCalc<-NULL
head(stats)
stats$xyz<-NULL
head(stats)
str(stats)

#filtering DataFrame
head(stats)
filter<-stats$Internet.users < 2 #returns vector w True False values
stats[filter,] #R will display only rows with True values

stats[stats$Birth.rate > 40,] 
#likewise we can dispense with a variable name and just pass in 
#the logical operation as is. This subset returns only the true values

stats[stats$Birth.rate > 40 & stats$Internet.users < 2,] 

stats[stats$Income.Group == "High income",]
stats[stats$Country.Name == "Malta",]
str(stats)

#----------------- Intro to qplot()
library(ggplot2)
?qplot()
qplot(data=stats,x = Internet.users)
#we passed in the DF stats and don't need to use $ to subset; 
#just call column names.
qplot(data=stats, x=Income.Group, y=Birth.rate, size = I(3),
      colour = I("blue"))
#note that column names are case sensitive
#I() in the arguments prevents qplot from mapping the input to the 
#DF values
str(stats)
qplot(data=stats, x=Income.Group, y=Birth.rate, geom = "boxplot")

#------Visualizing
qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate, color = I("red"),
      size=I(4)) #we need I() when the input applies to all data
#we do not need I() when setting a parameter, ie assigining a variable
qplot(data=stats, x=Internet.users, y=Birth.rate, color = Income.Group,
      size=I(4))

#---------Creating Data Frames
Countries_2012_Dataset <- c("Aruba","Afghanistan","Angola","Albania","United Arab Emirates","Argentina","Armenia","Antigua and Barbuda","Australia","Austria","Azerbaijan","Burundi","Belgium","Benin","Burkina Faso","Bangladesh","Bulgaria","Bahrain","Bahamas, The","Bosnia and Herzegovina","Belarus","Belize","Bermuda","Bolivia","Brazil","Barbados","Brunei Darussalam","Bhutan","Botswana","Central African Republic","Canada","Switzerland","Chile","China","Cote d'Ivoire","Cameroon","Congo, Rep.","Colombia","Comoros","Cabo Verde","Costa Rica","Cuba","Cayman Islands","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominican Republic","Algeria","Ecuador","Egypt, Arab Rep.","Eritrea","Spain","Estonia","Ethiopia","Finland","Fiji","France","Micronesia, Fed. Sts.","Gabon","United Kingdom","Georgia","Ghana","Guinea","Gambia, The","Guinea-Bissau","Equatorial Guinea","Greece","Grenada","Greenland","Guatemala","Guam","Guyana","Hong Kong SAR, China","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Ireland","Iran, Islamic Rep.","Iraq","Iceland","Israel","Italy","Jamaica","Jordan","Japan","Kazakhstan","Kenya","Kyrgyz Republic","Cambodia","Kiribati","Korea, Rep.","Kuwait","Lao PDR","Lebanon","Liberia","Libya","St. Lucia","Liechtenstein","Sri Lanka","Lesotho","Lithuania","Luxembourg","Latvia","Macao SAR, China","Morocco","Moldova","Madagascar","Maldives","Mexico","Macedonia, FYR","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Mauritius","Malawi","Malaysia","Namibia","New Caledonia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","New Zealand","Oman","Pakistan","Panama","Peru","Philippines","Papua New Guinea","Poland","Puerto Rico","Portugal","Paraguay","French Polynesia","Qatar","Romania","Russian Federation","Rwanda","Saudi Arabia","Sudan","Senegal","Singapore","Solomon Islands","Sierra Leone","El Salvador","Somalia","Serbia","South Sudan","Sao Tome and Principe","Suriname","Slovak Republic","Slovenia","Sweden","Swaziland","Seychelles","Syrian Arab Republic","Chad","Togo","Thailand","Tajikistan","Turkmenistan","Timor-Leste","Tonga","Trinidad and Tobago","Tunisia","Turkey","Tanzania","Uganda","Ukraine","Uruguay","United States","Uzbekistan","St. Vincent and the Grenadines","Venezuela, RB","Virgin Islands (U.S.)","Vietnam","Vanuatu","West Bank and Gaza","Samoa","Yemen, Rep.","South Africa","Congo, Dem. Rep.","Zambia","Zimbabwe")
Codes_2012_Dataset <- c("ABW","AFG","AGO","ALB","ARE","ARG","ARM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYM","CYP","CZE","DEU","DJI","DNK","DOM","DZA","ECU","EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MDA","MDG","MDV","MEX","MKD","MLI","MLT","MMR","MNE","MNG","MOZ","MRT","MUS","MWI","MYS","NAM","NCL","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PNG","POL","PRI","PRT","PRY","PYF","QAT","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SOM","SRB","SSD","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCD","TGO","THA","TJK","TKM","TLS","TON","TTO","TUN","TUR","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VIR","VNM","VUT","PSE","WSM","YEM","ZAF","COD","ZMB","ZWE")
Regions_2012_Dataset <- c("The Americas","Asia","Africa","Europe","Middle East","The Americas","Asia","The Americas","Oceania","Europe","Asia","Africa","Europe","Africa","Africa","Asia","Europe","Middle East","The Americas","Europe","Europe","The Americas","The Americas","The Americas","The Americas","The Americas","Asia","Asia","Africa","Africa","The Americas","Europe","The Americas","Asia","Africa","Africa","Africa","The Americas","Africa","Africa","The Americas","The Americas","The Americas","Europe","Europe","Europe","Africa","Europe","The Americas","Africa","The Americas","Africa","Africa","Europe","Europe","Africa","Europe","Oceania","Europe","Oceania","Africa","Europe","Asia","Africa","Africa","Africa","Africa","Africa","Europe","The Americas","The Americas","The Americas","Oceania","The Americas","Asia","The Americas","Europe","The Americas","Europe","Asia","Asia","Europe","Middle East","Middle East","Europe","Middle East","Europe","The Americas","Middle East","Asia","Asia","Africa","Asia","Asia","Oceania","Asia","Middle East","Asia","Middle East","Africa","Africa","The Americas","Europe","Asia","Africa","Europe","Europe","Europe","Asia","Africa","Europe","Africa","Asia","The Americas","Europe","Africa","Europe","Asia","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Oceania","Africa","Africa","The Americas","Europe","Europe","Asia","Oceania","Middle East","Asia","The Americas","The Americas","Asia","Oceania","Europe","The Americas","Europe","The Americas","Oceania","Middle East","Europe","Europe","Africa","Middle East","Africa","Africa","Asia","Oceania","Africa","The Americas","Africa","Europe","Africa","Africa","The Americas","Europe","Europe","Europe","Africa","Africa","Middle East","Africa","Africa","Asia","Asia","Asia","Asia","Oceania","The Americas","Africa","Europe","Africa","Africa","Europe","The Americas","The Americas","Asia","The Americas","The Americas","The Americas","Asia","Oceania","Middle East","Oceania","Middle East","Africa","Africa","Africa","Africa")

mydf<-data.frame(Countries_2012_Dataset, Codes_2012_Dataset,
                 Regions_2012_Dataset)
head(mydf)

#colnames(mydf)<-c("Country","Code","Region")
#head(mydf)

rm(mydf)

#another way to rename columns while you are creating the DF:-)
mydf<-data.frame(Country = Countries_2012_Dataset, 
                 Code = Codes_2012_Dataset, Region =Regions_2012_Dataset)
#this method is setting parameters:-)
head(mydf)
mydf
tail(mydf)
summary(mydf)
str(mydf)

#--------merging Data Frames

#we want to merge Regions from mydf to stats df
head(stats)
head(mydf)

merged<-merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)
merged$Country<-NULL
#Country is a duplicate column in the DF named merged. We
#remove it by subletting it and assigning it to NULL
head(merged)
str(merged)
tail(merged)
library(ggplot2)
#---------visualizing the merged DF
#my attempt
qplot(data = merged, x = Internet.users, y = Birth.rate, color = Region )
?qplot()
#alpha for transparency (0 - 1)
qplot(data = merged, x = Internet.users, y = Birth.rate, color = Region,
      size = I(3), shape=I(19), alpha=I(0.6), 
      main = "Birth Rate vs Internet Users")
?qplot()
