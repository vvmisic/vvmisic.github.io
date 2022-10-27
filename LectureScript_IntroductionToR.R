# MGMTEX 402
# Introduction to R
# In this script, we will provide a short introduction to the basic
# features of R and RStudio.

####### LAYOUT OF RSTUDIO #######
# 
# In RStudio, you will usually see four panes:
#
# Top left: this one shows the script you have open. 
# A script is just a text file which contains R commands for performing some
# analysis 
#
# Bottom left: this one shows the console. This shows what
# commands you have run so far, and any output from those commands.
# If you have used the DOS prompt / command line in Windows or the
# Terminal on a Mac, this operates very similarly. 
# 
# Top left: shows either History (just the commands you have run so
# far) or the Environment (what variables/objects exist in the workspace).
#
# Bottom right: shows either Help (which shows information about commands)
# or Plots (shows any scatter plots, histograms, etc. that you may have
# generated using a command).


####### SCRIPTS #######
# A script is a collection of R commands. 
# The idea of the script is that you can save the R commands you are 
# using to perform an analysis or demonstrate something. You can
# then re-use them in the future, or share them with others.

####### RUNNING COMMANDS ####### 
# There are two ways of running commands. The first way is to
# just type the command into the console, and hit Enter/Return.
# For example, run the command below in the console:
5 + 6 * 30

# This command takes 5 and adds 6 times 30 to it (output is 185). 

# The other way is to put your cursor in the script pane on the line
# you want to run, and to then hit Control+Enter (on Windows) or
# Command + Return (on Mac)
# Try the command above again.

# Try running the commands below just directly from the script pane:
77 / 11
(1000 - 55) / (33 + 66)
2^3 + 2^18 + 2^19

# If you try running an incomplete command, R will show a + in the console.
# This means that it is waiting for further input from you to complete the command.
# Try typing the example below, and hitting Enter/Return after the / :
# (1000 - 55) / 


####### COMMENTS #######
# A comment is a line of code that starts with the hashtag symbol (#)
# This basically tells R that this is just an annotation or note
# that you have made, and does not contain runnable code. 
# The idea of a comment is to explain to someone (either yourself or
# another person) what the line of code is doing. Sometimes comments
# are also used to "disable" a line of code but to keep it in the script
# in case you want to try it later.
# The scripts that we will work with will have lots of comments to
# explain what is going on. 

####### VARIABLES #######
# A variable in R is a way of storing and giving a name to a quantity.
# To define a variable we write the variable name, followed by a =,
# followed by an expression that gives its value.

x = 235.6

# You can name your variable anything, but you cannot start the
# name with a _ or a number. 

# You can create variables from other variables:
y = x + 77
y

y = y + 1000 
y
z = 1200 / y
z

# Variable names are case sensitive. For example, try running the
# two lines below:
LengthOfStay = 12
lengthofstay

# Variables do not have to be numbers. They can also be strings.
# For example
name = "John Doe"
name

# Exercise: Create a variable called SecondsDay that is equal to 
# the number of seconds in a day, and output its value.

SecondsDay = 24 * 60 * 60
SecondsDay


####### FUNCTIONS #######
# A function is a procedure that takes some inputs and produces an output.
# R provides lots of functions that you can use to do various calculations.
# For example

# Square root:
sqrt(1000)

# Absolute value:
abs(-500)

# Natural logarithm:
log(2.7182)

# Cumulative probability under normal distribution.
# (E.g., P(X < 150), where X ~ Normal(200,40); in Excel,
# this would be NORM.DIST(150, 200, 40, true)
pnorm(150, 200, 40)



####### VECTORS #######
# A vector is a collection of objects stored as a single object.
# For example:
dice.numbers = c(1,2,3,4,5,6)
dice.numbers

# A simpler way to do the above is to use the colon:
dice.numbers = c(1:6)
dice.numbers

# Some other examples:

country.names = c("Australia", "Brazil", "China", "Dominican Republic", "Ecuador", "France")
country.names

GNP.per.capita = c(52240, 14550, 17090, 17060, 10580, 47720)
GNP.per.capita

# You can access specific elements of vectors using square brackets.
# For example:
country.names[4]
GNP.per.capita[4]

# For many functions in R, you can pass a vector as an input,
# which would result in the function being applied to each element
# in the vector. 
# For example:

# Take the log of numbers 1 through 6
log(dice.numbers)

# Convert all strings in countries to lower case:
tolower(country.names)


####### DATAFRAMES #######

# A dataframe is essentially a two dimensional table that has 
# rows and columns, and where the columns have names.
# To create a data frame, we use the data.frame() command. 
# Each input in data.frame() looks like 
# columnname = ...
# where columnname is the name we give to the column, and ...
# is where we specify the set of values. 

movies.df = data.frame(title = c("The Shawshank Redemption", "The Godfather", "Star Wars"), year = c(1994, 1972, 1977), rating = c(9.3, 9.2, 8.6))
movies.df

# To access a specific column, we use the $ followed by the column name:
movies.df$title
movies.df$year
movies.df$rating

# We can also define new columns using $ . For example:
movies.df$director = c("Frank Darabont", "Francis Ford Coppola", "George Lucas")
movies.df

# We can also do it with expressions involving columns. For example:
movies.df$rating.out.of.5 = movies.df$rating / 10 * 5
movies.df

# We can also create data frames out of existing vectors. For example
country.df = data.frame(name = country.names, GNP.per.capita = GNP.per.capita)
country.df


####### READING DATAFRAMES FROM FILES #######

# The most common way we will create dataframes is by reading them from files.
# We can do this using the read.csv command.
# CSV (comma separated values) is a file format for storing data. 
# It's just a text file -- you can open it in Notepad (on Windows) or
# TextEdit (on a Mac), or any other text editor. 
# If you open a CSV in Excel, it will automatically format it into a 
# legible table.
#
# Let's read the file nhanes-diabetes.csv.
# All of the CSV files that we will see in this class will be hosted
# on my personal website, and we will load them by reading from a 
# web link:
diabetes.df = read.csv("https://vvmisic.github.io/nhanes-diabetes.csv")

# It is possible to load CSV files locally on your computer. 
# This requires some more care, because the directory/folder that RStudio is in
# may not be the same as the directory/folder that the CSV file is in.


# nhanes-diabetes.csv is a sample of people who completed a survey
# administered by the US National Center for Health Statistics.
# It includes information about whether they have diabetes, 
# their weight, age, height, household income, how many hours of sleep
# they get per night, how often they feel depressed, etc.

# We can view the data frame by just typing it into the prompt:
diabetes.df

# This is a big data frame, so it won't display completely in our
# console.

# For big data frames, it's often more convenient to use the functions
# str() ("structure") and summary():

str(diabetes.df)
# We can see there are 5763 observations (rows), and 28 variables (columns).
# str() also displays the type of each column: 
# int (integer)
# num (numeric; could be non-integer/decimal number)
# chr (character; this indicates strings)
# It also displays the first few values of each column.

# Let's try summary():
summary(diabetes.df)

# summary will output summary information for each column. 
# For numeric columns, it gives the minimum, maximum, mean, median, 
# and 1st and 3rd quartiles. 

####### COMMANDS TO WORK WITH DATAFRAMES #######

# There are lots of commands for analyzing dataframes. We will 
# introduce several general ones right now; others we will introduce as 
# we go through later scripts.

# The nrow command will count the number of rows:
nrow(diabetes.df)

# The ncol command will count the number of columns:
ncol(diabetes.df)

# The mean, median and sd commands can be used to calculate the mean,
# median and standard deviation of a column:
mean(diabetes.df$Age)

# The table command will count the number of rows that 
# have different values. For example:
table(diabetes.df$MaritalStatus)
table(diabetes.df$Diabetes) #1 means person has diabetes, 0 means they do not.

# table can also be used with two inputs. For example, suppose we want
# to count the number of people in the sample by education and gender:
table(diabetes.df$Gender, diabetes.df$Education)

# The tapply command will apply an aggregation function
# to a column of values that is to be grouped according to another column.
# For example, what is the average age by marital status in this
# sample?
tapply(diabetes.df$Age, diabetes.df$MaritalStatus, mean)

# The first input is the quantity that we are aggregating;
# the second is the column that contains the groupings of the values;
# the third is the aggregation function to use (something that takes a 
# vector of values and returns a single value -- e.g., like mean).

# Let's see another example. What is the median weight of individuals
# depending on how many days they report feeling depressed (this is the
# Depressed variable)?
tapply(diabetes.df$Weight, diabetes.df$Depressed, median)


# Finally, the plot command is useful for producing scatter plots.
# Let's plot height and weight against each other:
plot(diabetes.df$Height, diabetes.df$Weight, xlab = "Height", ylab = "Weight")
# The first input is always the vector of values to use as the 
# x-coordinate, and the second is always the vector of values to use
# as the y-coordinate.
# The (optional) inputs xlab =... and ylab =... allow us to specify the axes
# headings.


####### SAVING A SCRIPT #######

# Finally, once you are done with writing/modifying a script, you can
# save it in RStudio by going to "File" > "Save as" and choosing a file name.
# This way, you can later open your script and run it again, or share it
# with someone else. 
