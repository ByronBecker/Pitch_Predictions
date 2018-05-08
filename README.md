> # Pitch_Predictions
### Sabermetrics Final Project

See the App at http://byronbecker.github.io/!!!

### Goal
> To be able to predict if pitches will be called a ball, called a strike, are swinging strikes, or are hit in better than a 1/4 chance (baseline) by using pitch f/x data. In getting to the prediction, I'm most interested in which factors impact swinging strikes.


### Methodology

1. First, the 2 months of the 2017 of Pitch f/x data (over 830,000 pitches!) was scraped from mlb.com using John Choiniere's pfx-parser https://github.com/johnchoiniere/pfx_parser.
2. Then the data was then imported to MySQL and massaged in order to break down all pitches into 4 possible outcomes or 'pitch events'. These pitch events were:
	* A Ball - includes hit by pitches, pitchouts, and intentional balls in addition to normally called balls
	* A Swinging Strike - includes foul tips, missed bunts, and foul-out bunts in addition to swing-and-miss strikes
	* A Called Strike 
	* A Ball Hit - includes fouls, and pitches in play
3.  The result of a MySQL query was then imported into a jupyter notebook, where the data was statistically analyzed as follows
	* First, a correlation matrix was computed for all the pitch f/x features for the data, and then used this to eliminate all (noisy) features with a low magnitude Pearson Correlation Coefficient (< 0.1).
	* Then, the data was split into a test set and train set
	* Then, the data was run through a Logistic Regression, Neural Network (Multi-layer Perceptron), and K-Nearest Neighbors algorithm to see which algorithm performed best
	* K-Nearest Neighbors not only performed the best (62% accuracy) on the "training round", but was the most easily interpretable and configurable, so it was chosen.
4. Then, 2 days worth of "validation" data (6,716 pitches) was chosen from all games during August 1st & 2nd of 2017. This data went through the same process as the other data, except for the fact that after configuring the data in MySQL, the data was imported to the jupyter notebook and run straight through the pre-configured KNN algorithm, from which it received a classification accuracy score of 59%.
5. An app was then made to graphically show the places in the strike zone where the app was both correctly and incorrectly classifying for each of the validation set games (see it at http://byronbecker.github.io/) 

### Navigating this Repo
1. To see the work done in the jupyter notebook, either see the actual notebook at Pitch_Predictions.ipynb, or a PDF of the notebook and it's outputs at Pitch_Predictions_Notebook.pdf
2. For the work done in MySQL 
	- create_pitch_table.sql & create_test_pitch_table.sql are creating the tables for the initial train/test and validation data, respectively.
	- import_pitch_table.sql & test_visualization_data_import are importing that data, massaging it, and assigning encoding outputs for the machine learning algorithm to train/test off of.

### The App, and my Conclusion
The Pitch Prediction App that I built attempts to visualize to see how well a basic classifier can predict the 2 days worth of classified pitches based on just pitch f/x data. From the "Select Game Data" dropdown, you pull up the pitches for each game. For each game, you can switch between the following 3 different modes:
1. Actual Pitches - what was the actual outcome of the pitch in the game
2. Predicted Pitches - what did the classifier predict as the outcome?
3. Pitch Classification Correctness - which pitches did the classifier get right, and which did it get wrong?

Each mode has different color codes for correctness/classification to help the viewer internalize where the algorithm is incorrectly classifying outcomes, and where it is doing very well. In addition, one can view the overall classification correctness % for a particular game.

After playing with the Pitch Prediction App a bit, it is evident that the app excels at classifying un-hittable, easy balls (way out of the strike zone), and as it nears the strike zone, that accuracy lowers far below 50%, as it becomes more difficult to predict outcomes, with the highest percentage incorrectly predicted classifications coming on the edges or "corners" of the strike zone.

Going forward, I think this would be a very interesting problem to look at in more granular detail, doing some feature engineering to my algorithm, such as looking at individual classifications for the 4 different pitcher/batter hand matchups, separating and visualizing the data for different pitches that are thrown, and clustering batters and pitchers together to then look at the chart for matchups between players of various "types".


### Curious About the Data??
I purposely left out the csv files from this repo as they were too large (GitHub wouldn't allow it anyways). If you are interested, please reach out to me or email me.

