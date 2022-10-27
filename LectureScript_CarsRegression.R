# MGMTEX 402
# Simple and Multiple Regression
# In this R script, we will introduce simple regression using 
# a data set on used cars, and then introduce multiple regression
# using the same data.

####### LOADING THE DATA ######

cars = read.csv("http://vvmisic.github.io/car-data-2019.csv")
str(cars)
summary(cars)


####### BUILDING THE REGRESSION MODEL ####### 

# We build a linear regression model using the function lm() 
# (lm stands for "Linear Model"): 
cars.lm = lm(Value ~ Age, data = cars)

# In the above, the first input is what is called a "formula".
# The variable to the left of the ~ is the dependent variable. 
# The variable to the right of the ~ is the independent variable.
# (Formulas can be much more general than this -- and we will see more
# complicated examples -- but for now we will consider just this simple
# case.)
# The second input is data = cars, which specifies which data frame is
# to be used to estimate the linear regression model. 

# Inspect the model:
summary(cars.lm)

# The important things to extract:
# 1) Intercept is 32104.5, slope is -2417.3
# Intercept = 32104.5 means that our predicted value for a new car
# (i.e., one with Age = 0) is $32,104.5. 
# Slope = -2417.3 means that for each additional year of age, the 
# predicted value of the car decreases by $2417.30. 
# 
# (Write the regression equation on the board.)
#
# 2) The Age variable is highly statistically significant. You can see
# this from the last column of the table labelled "Coefficients:", which has the 
# heading Pr(>|t|). (This column contains the p-value.) 
# The p-value is 2.88 * 10^{-10}, which means that assuming the true slope is zero,
# then the probability of getting this estimate or something more extreme (i.e.,
# a slope <= -2417.3 or a slope >= +2417.3) is roughly 3 in 10 billion. For a 
# significance level of alpha = 0.05, we would conclude that the Age variable is
# statistically significant. 
# (Note that R also outputs asterisks, i.e., ***, which indicate where the p-value falls.
# See the legend under the "Coefficients" table.)
# 
# 3) The R^2 is 0.4759. (This is indicated in the output by "Multiple R-squared".) 
# This means that 47.59% of the variability in the value of a used car is explained 
# by this model. (Alternatively, if we were to compare this model to the baseline model 
# that always predicts the average value, then this model reduces the squared error of 
# that model by 47.59%.)
# Although we will not discuss it right now, let us also make a note here that the 
# adjusted R^2 is 0.4675.


####### PLOTTING THE REGRESSION MODEL ####### 

# We can plot the data and the regression model using plot() and abline().
# In particular:
plot(cars$Age, cars$Value, xlab = "Age", ylab = "Value")
abline(cars.lm)

####### MAKING A PREDICTION####### 

# Suppose we have a car that is 10 years old. 
# We can make a prediction by manually plugging the value of 10
# into the regression equation:
32104.5 - 2417.3 * 10
# $7931.5

# We can also do this using the predict() function. First, create
# a new data frame, which has the same column names as the independent variables
# of your model:
new.cars = data.frame(Age = 10)

# Then use the predict() function, where the first input is the regression model
# (in our case, cars.lm) and the second input is newdata = new.cars
new.cars.predict = predict(cars.lm, newdata = new.cars)

# The above way of making predictions can also be extended when we have 
# multiple new observations. 
# For multiple cars, we do the same as above, but modify it as follows:
new.cars = data.frame(Age = c(10, 12, 6, 4))

# In the above, a list of numbers inside c() will specify a vector or a list.
new.cars.predict = predict(cars.lm, newdata = new.cars)
new.cars.predict


####### MULTIPLE REGRESSION ####### 

# Let's now create a richer model, by adding another variable: Mileage.
# We run lm() again, but we now specify the formula differently:
cars.lm = lm( Value ~ Age + Mileage, data = cars)

# In the new formula, Value ~ Age + Mileage, we are telling R that 
# Value is (still) the dependent variable, but now we are to use Age 
# and Mileage as independent variables.

# Let's inspect the regression model:
summary(cars.lm)

# From the summary we see:
# 1) The intercept is $32090; this means that the predicted re-sale value 
# of a car that is new (Age = 0) and has zero miles on it (Mileage = 0)
# is $32090. 
# 2) The slope of Age is -2436. For each additional year of use, the predicted 
# re-sale value goes down by $2436. 
# 3) The slope of Mileage is 0.001977. For each additional mile on the odometer,
# the predicted re-sale value goes up by $0.001977. (For an additional 10,000
# miles, the predicted re-sale value goes up by $19.77.)
# We will discuss the reason for this strange result shortly. 
#
# (Write the regression equation on the board.)
#
# 4) The new R^2 is 0.476. (Previously, it was 0.4759.) Remember from the slides
# that ordinary R^2 (what R calls "Multiple R-squared") either stays the same or 
# increases when you add new variables.
#
# 5) The adjusted R^2 (what R calls "Adjusted R-squared") is 0.4588. Remember that 
# the first model had an adjusted R^2 of 0.4675. From a model selection viewpoint, 
# we would actually prefer the first model (which only had Age) over this new one, 
# as the adjusted R^2 decreased after we added Mileage.
#
# 6) The p-value of Age is 0.00436. At the alpha = 0.05 level, Age is still 
# statistically significant. The p-value of Mileage is 0.973910. At the alpha = 0.05 level
# Mileage is not statistically significant, and we would conclude that there isn't a dependence
# between Mileage and Value. 
#
# 7) The standard error of the regression (what R calls "residual standard error")
# is $11,100. This means that on average, our model makes an error of about $11,100
# on each observation.



# Let's now try to make some predictions. Suppose we have three cars with:
# Age = 2, Mileage = 60000
# Age = 5, Mileage = 100000
# Age = 7, Mileage = 80000
# To make predictions for these cars, create a new data frame, and specify each
# column of that data frame:
new.cars = data.frame(Age = c(2,5,7), Mileage = c(60000, 100000, 80000))

# Open new.cars just to see what it looks like:
new.cars

# Now use predict:
new.cars.predict = predict(cars.lm, newdata = new.cars)
new.cars.predict


####### PREDICTION INTERVALS ####### 

# Let's now construct a prediction interval for these predictions.
# We can do this using predict, by specifying two additional parameters:
# interval and level.
new.cars.predict.interval = predict(cars.lm, newdata = new.cars, interval = "prediction", level = 0.95)
new.cars.predict.interval

# The new object has three columns: the first contains just the predicted value (same as before).
# Columns 2 and 3 give the lower and upper bounds for the prediction interval.
# Here, because the standard error of the regression is very large ($11,100), the prediction intervals
# are very wide, and for two of them the lower bound actually goes below zero. 
# For more accurate models, with a lower standard error of the regression / higher R^2, the 
# prediction interval will generally be narrower. 

####### MULTICOLLINEARITY ####### 

# In our multiple regression model, Mileage was not statistically significant;
# moreover, the sign of Mileage was counter to what we'd expect. (We would expect
# Mileage to have a negative slope; the more miles on a car's odometer, the less
# people would be willing to pay for it due to wear and tear.)
# 
# This arises because of multicollinearity. As discussed in the slides, when two
# or more variables have a strong correlation, this can distort the estimated slopes.
# 
# We can check for correlations using the cor() function applied to two columns of a
# data frame. In particular:
cor(cars$Age, cars$Mileage)

# Age and Mileage have a *very* strong positive correlation: 0.8683.
# Why are Age and Mileage positively correlated?
