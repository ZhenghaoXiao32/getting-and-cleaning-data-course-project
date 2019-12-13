# Getting and Cleaning Data Course Project

## Introduction
This is the course project of coursera data science: getting and cleaning data. The purpose of this project is to create a clean dataset from collecting data. The original dataset is [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Files contained
This project has three main files: 

* **`run_analysis.R`** 
* **`codebook.md`**
* **`tidy.txt`**

## Contents
The process of cleaning and getting data is recorded in the `run_analysis.R` script. There are several steps to get the final tidy dataset:
* Download and unzip the dataset
* Extract the label data
* Select labels with mean and standard deviation
* Supplement more information to the original variables names
* Load the training and test datasets
* Combine those datasets with appropriate labels
* Calculate the mean of the dataset 
* Save the final tidy dataset

`codebook.md` listed all the variables and summaries in the tidy dataset.

The final tidy dataset is shown in the file `tidy.txt`


## Citation
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

## License
The contents of this repository are covered under the [MIT License](LICENSE).

