#Authors: Brian King and Malik Mubeen
#Stat 31 Final Project

#Read in tennis data: 
setwd("/")
setwd("Users/King/Dropbox/Brian/Swarthmore/Swat Year 4/Stat 31/final project")
data = read.csv("tennisdata.csv")

colnames(data)
library(ggplot2)
qplot(unforcedErrors, Aces, data = data, geom = "point", color = player, size = fspw)


#The data set was gathered off of european sports betting websites for the past three years of majors 
#(2013 Australian Open back to the 2011 Australian Open) for the current four top rated ATP Players: 
#Rafael Nadal, Roger Federer, Novak Djokovic, and Andy Murray.


player      = data$player			#Player Name
fsp         = data$firstServePercentage		#First Serve Percentage
aces        = data$Aces				#Number of Aces in a match
ue          = data$unforcedErrors 		#Unforced Erros 
fspw        = data$fspw 			#First Serve Win Percentage
sspw        = data$sspw				#Second Serve Win Percentage
winners     = data$winners			#Winners (is a discrete count of winners in a tennis match)
bpcp        = data$bpcp 			# Break Point  Conversion Percentage
fset        = data$fset				#First Set: Bernoulli random variable if player won or lost first set
match       = data$match 			#Bernoulli if player won or lost match
surface.raw = data$Surface			#surface.raw is a string, either 'Hard', 'Clay', or 'Grass'
numSets     = data$numSets			#Number of Sets


#Create category variable for different surfaces
# 1 if grass court, 2 if clay court, 3 if hard court

length(surface.raw)
surface = rep(0,210)
surface[which(surface.raw == 'Grass')] = 1
surface[which(surface.raw == 'Clay')] = 2
surface[which(surface.raw =='Hard')] = 3

### Averages ####
#Here we're taking "count" data and dividing it by the number of sets in the match to 
#account for longer matches. A player who is losing a five set match will hit more aces (because he's
# playing so many games) just as a player who is handily winning a three set match against a weaker opponnet
#. This metric probably isn't perfect but will help with that issue. 

avgAces = aces/numSets			#Average Number of Aces
avgWinners = winners/numSets  	#Average Number of Winners
avgUe = ue/numSets 			#Average Number of Unforced Errors




### Simple Logistic Regression 


 #Try a simple 1 variable it for each player
 #This methodology is admittedly imperfect since we're only checking p-values and not much else
 #(AIC can only compare two models that are related, but comparing AIC across players seems implausable).
 #However, we really just want to see which variables are reasonably correlated with winning.
 players = c("Djokovic", "Federer", "Nadal", "Murray")
 #We switched variables in manually
for (i in 1:length(players)){
	if (i ==1){ print ("***Surface****")}
	test.glm = glm(match[which (player == players[i])]~surface[which (player == players[i])],
		family = "binomial")
	print (players[i])
	print ("P-Value:" )
	print(summary(test.glm)$coefficients[2,4]) ; 
}


### Full Models ###

#Murray GLM

test.glm = glm(match[which (player == "Murray")]~avgAces[which (player == "Murray")] + 
		avgWinners[which (player == "Murray")] + fsp[which (player == "Murray")] + 
		avgUe[which (player == "Murray")] + fset[which (player == "Murray")] +
		bpcp[which (player == "Murray")] + fspw[which(player == "Murray")],
		family = "binomial")

summary(test.glm)
length(which(player == "Murray"))
which(test.glm$fitted.values < .5) + 153 
which( player == "Murray" & match == 0)

classification.error = (3 + 5)/ 57

#Federer GLM

test.glm = glm(match[which (player == "Federer")]~avgAces[which (player == "Federer")]
	+ avgWinners[which (player == "Federer")] + fsp[which (player == "Federer")]
	+ avgUe[which (player == "Federer")] + fset[which (player == "Federer")]
	+ bpcp[which (player == "Federer")] + fspw[which(player == "Federer")] 
	+ numSets[which (player == "Federer")]  , family = "binomial")
	
summary(test.glm)

length(which(player == "Federer"))
which(test.glm$fitted.values < .5) + 42 
which( player == "Federer" & match == 0)

#Nadal GLM

test.glm = glm(match[which (player == "Nadal")]~avgAces[which (player == "Nadal")] +
	avgWinners[which (player == "Nadal")] + fsp[which (player == "Nadal")] +
		avgUe[which (player == "Nadal")] + fset[which (player == "Nadal")] +
		bpcp[which (player == "Nadal")] + fspw[which(player == "Nadal")],
		family = "binomial");summary(test.glm)
		
which(player == "Nadal")
which(test.glm$fitted.values < .5)
which(player == "Nadal" & match == 0)

#Djokovic GLM

test.glm = glm(match[which (player == "Djokovic")]~avgAces[which (player == "Djokovic")] 
	+ avgWinners[which (player == "Djokovic")] + fsp[which (player == "Djokovic")] + 
	avgUe[which (player == "Djokovic")] + fset[which (player == "Djokovic")] +
	bpcp[which (player == "Djokovic")] + fspw[which(player == "Djokovic")] , family = "binomial")

summary(test.glm)

which(player == "Djokovic")
which(test.glm$fitted.values < .5) +94
which(player == "Djokovic" & match == 0)


### Reduced Models ####

#Note: The procedure for obtaining these reduced models was checking the Akaike Information Criterion and 
#and attempting to minimize it by removing each variable once and watching it's effect and iterating. 
# I'm pretty sure there's a way better, less ad-hoc way to achieve this.

#Murray GLM Reduced
test.glm = glm(match[which (player == "Murray")]~avgUe[which (player == "Murray")] +
	fset[which (player == "Murray")] +bpcp[which (player == "Murray")] +
	fspw[which(player == "Murray")] , family = "binomial");summary(test.glm)

#Classification Error
which(player == "Murray")
which(test.glm$fitted.values < .5) + 153 
which( player == "Murray" & match == 0)

#Murray's Model: Log odds of winning = First Set + Average Unforced Errors + Break Point Conversion
# Percentage + First Serve Percentage Wins

#Federer GLM Reduced

test.glm = glm(match[which (player == "Federer")]~avgAces[which (player == "Federer")]
	+ avgWinners[which (player == "Federer")] + avgUe[which (player == "Federer")] 
	+ fset[which (player == "Federer")] +bpcp[which (player == "Federer")] 
	+ fspw[which(player == "Federer")]  , family = "binomial")

summary(test.glm)

#Classification Error
length(which(player == "Federer"))
which(test.glm$fitted.values < .5) + 42 
which( player == "Federer" & match == 0)

#Federer's Model : Log odds of winning = First Set + Average Number of Aces + Average Number of 
#Winners + Average Unforced Errors + Break Point Conversion Percentage + First Serve Percentage 
#Wins

#Nadal GLM Reduced

test.glm = glm(match[which (player == "Nadal")]~   fset[which (player == "Nadal")] +
	bpcp[which (player == "Nadal")] + fspw[which(player == "Nadal")]  , family = "binomial")

summary(test.glm)

#Classification Error
which(player == "Nadal")
which(test.glm$fitted.values < .5)
which(player == "Nadal" & match == 0)


#Nadal's Model: log odds of winning = first set + break point conversion percentage + first serve 
#percentage wins

#Djokovic GLM Reduced

test.glm = glm(match[which (player == "Djokovic")]~ avgUe[which (player == "Djokovic")] + 
	fset[which (player == "Djokovic")] + fspw[which(player == "Djokovic")], family = "binomial")

summary(test.glm)

# Check Classification Error
which(player == "Djokovic")	#It shifts over the indices so we're just moving them back
which(test.glm$fitted.values < .5) +94
which(player == "Djokovic" & match == 0)


#Djokovic's Model : log odds of winning =  First Set+ Average Unforced Errors + First Serve 
#Percentage Wins

