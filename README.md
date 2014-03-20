tennis_models
=============

![roger](roger-federer-1-sized.jpg)


A fun project to try to model Roger Federer, Andy Murray, Novak Djokovic, and Rafael Nadal's playing styles with 
data scraped off of european gambling websites on the past five years of tennis majors. We basically did stepwise logistic
regression without knowing what stepwise logistic regression was, looking at Aikake's Information Criterion and Likelihood Ratios to tune the models.

Some interesting findings:
- Nadal and Djokovic's match win's are almost entirely uncorrelated with winning the first set (not the case with Federer and Murray).You can beat them in the first set and be almost no better at predicting the result of the match (which is kind of insane).
- A complex, graceful tennis animal, Federer's game takes quite a few variables to tune a model--you basically need metrics on all aspects of his game to classify his wins (How is Roger serving? Is he converting on his break points? Did he get off to a good start? Is he playing aggressively?, etc.);
- Conversely, if Novak and Rafa serves are on, you can basically call the match for them.
- We couldn't find any combination of variables that could  classify Murray's wins and losses better than 84%, probably attribut ble to his variable, defensive playing style which is hard to read. He is also a very emotional tennis player prone to the passionate fits of rage and joy on the court. He is unpredictable, emotional, and awesome. We love Andy.


Completed with Malik Mubeen (2013)
