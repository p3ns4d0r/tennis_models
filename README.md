tennis_models
=============

![roger](roger-federer-1-sized.jpg)


A fun project to try to model Roger Federer, Andy Murray, Novak Djokovic, and Rafael Nadal's playing styles with 
data from Gambling Websites based on the past five years of tennis majors. We basically did stepwise logistic
regression without knowing it existed, looking at Aikake's Information Criterion and Likelihood Ratios to tune the models.

Some interesting findings:
- Nadal and Djokovic's match win's are almost entirely uncorrelated with winning the first set (not the case with Federer and Murray).You can beat them in the first set and, without knowing anything else, you will be almost no better at predicting the result of the match.
- Modeling Federer's game takes quite a few variables; if you know Djokovic and Nadal's serves are going well, you can basically call the match.
- We couldn't find any combination of variables that could properly classify Murray's wins and losses, probably attribut ble to his variable, defensive playing style which is hard to read.
