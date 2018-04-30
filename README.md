# Pitch_Predictions
Sabermetrics Final Project


### Goal
> To be able to predict if pitches will be called a ball, called a strike, are swinging strikes, or are hit in better than a 1/4 chance (baseline) by using pitch f/x data. In getting to the prediction, I'm most interested in which factors impact swinging strikes.


### Current Status (4/30)

> Data has been retreived, and used dummy encoding to make the 4 outcomes binary (instead of categorical). Have looked at correlations to filter out some parameters that don't seem relevant, and am doing some basic logistic regression on a section of the data, and am going to apply it to a hold out set. I'm also looking into other approaches I can use, as well as different ways I can group the data to give more effective parameters (i.e. xor bat hand and pitch hand to determine if matching up a batter with a pitcher based on the hand they hit with/pitch with has an effect).
