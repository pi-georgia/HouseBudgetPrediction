##Real-Estate Budget Planner

author : Georgia-Pi
date : Sep 2015

**Real-Estate Budget Planner** is a tool to help you plan your budget for real-estate investments. 

Is is an interactive shiny app that takes into account **your preference criteria** and analyzes market data to provide you with a **budget range estimate for your specifics**. It also presents you with the price distribution for your selected criteria, as well as a correlation of Price and Price per square meter for your selected criteria.

This is a demo version with the following characteristics :

###INPUTS

  - **Area** : City Center, North Suburbs, South Suburbs | Select one
  - **Asset Type** : Flat, House, Maisonette, Other. | Select one or multiple
  - **Rooms** :  Range of 1 - 10. | Slide to set min and max 
  - **Surface** : Range of 10- 1000 | Slide to set min and max
  
###DATASET
For demonstration purposes, market data from classifieds published for Athens in January 2014 have been used. Data are a random sample thus not exhaustive. 
Please refer to the Codebook for more information.

###PREDICTION ALGORITHM

The function that predicts the budget is defined as  **houseBudget**.
To derive the prediction for budget a simple T-test is used. Estimated Budget limits correspond to the Confidence Intervals.
The function returns five values in form of a list : 
  1.MIN Price of estimated budget
  2.MAX Price of estimated budget
  3.All the asset prices corresponding to the selected criteria (subset)
  4.Prices per square meter for the subset
  5.Property types for the subset
  
###OUTPUTS
The app presents the budget estimates for the selected criteria.
It also plots the 
 - **Price distribution**
 - **Price and Price per square meter correlation**. Different colors correspond to different property types.
 
##USAGE
 1. Select your criteria and click refresh.
 2. Monitor main panel where the results are presented
 3. Shall you wish to change your criteria, update and click refresh for a new prediction.

