# Courssera_GCD_Project
##Getting the data
First of all, I downloaded the zipped folder, unzipped it, and downloaded files necessry for the analysus.

##Looking at data
Next, I previewd data sets to understand their structire and my next steps: how many columns and rows they have etc.

##Manipulating data
1. I assigned the features variable as column names to X_test and X_train
2. I created a vector of column names containing "mean()" and "std()" to subset the dataframe
3. I selected only columns containing these column names
4. I added two more variables to the two dataframes X_test and X_train
5. I united X_test and X_train
6. I re-coded the labels variable so that it now reflects the descriptive names of activities performed.

##Creating a new dataset
1. Using dplyr function group_by and summarise_all I created a new dataset which summarised all varibles by subject adn by activity type (averages). 
