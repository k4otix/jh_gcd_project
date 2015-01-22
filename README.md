# run_analysis.R

Getting and Cleaning Data - Course Project

This github repo contians the file run_analysis.R, which will read in the UCI HAR Dataset, perform several functions to clean and extract a subset of the data, and write a tidy data set (tidy.txt, included in the repo).  The file CodeBook.md describes how the data was obtianed and processed, as well as more information about the variables contained in the data.

## Instructions for use

To use this R script, do the follwing:  
1. Download the UCI HAR Dataset to the same directory as the R script [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
2. Unizip the archive  
3. Run the command `Rscript run_analysis.R`. The script will generate tidy.txt and exit  
  * To interact with the data start R and run `source("run_analysis.R")`) 

Dependenicies: dplyr

Additional detail about the variables and data can be found in the file CodeBook.md

Note: This code was run with R v3.1.2
