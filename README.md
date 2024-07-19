# Kittiwake Data Analysis Project

## Project Overview

This repository contains the project which involves comprehensive data analysis on the kittiwake population, focusing on exploratory data analysis (EDA), statistical modeling, and visualization to address various research questions related to kittiwake observations, historical trends, morphological measurements, and geographical location aspects.

## Contents

- **Kittiwake_Project**: R script containing the code used for data analysis and visualization.
- **Datasets**:
  - **ObservationData.csv**: Daily observations of kittiwakes over a span of four weeks.
  - **HistoricalData.csv**: Historical data of kittiwake breeding pairs across multiple sites over six time points (2000-2020).
  - **MeasurementData.csv**: Morphological measurements of kittiwakes, including weight, wingspan, and culmen length for both black-legged and red-legged sub-species.
  - **LocationData.csv**: Environmental data and breeding pairs information for different geographical locations.
  - **Kittiwake_Report.pdf**: Detailed report documenting the methodology, analysis, and findings of the project.

## Project Objectives

The main objectives of this project are to address the following research questions:

1. **Exploratory Analysis of Observation Data**: 
   - Provide an exploratory analysis of the observation data.
   - Construct a 90% confidence interval for the mean number of kittiwakes observed at noon.

2. **Historical Data Analysis**: 
   - Does the historical data support the hypothesis that the decline in kittiwake numbers over time is independent of the site?
   - Provide an estimate for the number of breeding pairs at Site B in 2009.

3. **Morphological Measurements Analysis**: 
   - For each sub-species, is wingspan and culmen length independent?
   - Is there evidence that the weights of birds of the two sub-species are different?
   - From the data provided, is there evidence that there is a difference between the two sub-species?

4. **Location Data Analysis**: 
   - Fit a linear model to predict the number of breeding pairs.
   - Fit a linear model to the logarithm of the number of breeding pairs.
   - Choose the most appropriate linear model for the data.
   - Comment on the model fit and the effect of the selected covariates on the number of breeding pairs.
   - Provide an 80% confidence interval for the number of breeding pairs at a site with specified environmental conditions.

## Methodology

### Exploratory Data Analysis (EDA)

- **Data Import**: Reading the dataset into R for analysis.
- **Data Visualization**: Using histograms and QQ plots to visualize distributions and assess normality.
- **Confidence Intervals**: Constructing a 90% confidence interval for mean observations at noon using t-tests.

### Historical Data Analysis

- **Data Reshaping**: Transforming data for compatibility with statistical tests using the `melt` function.
- **ANOVA**: Using Analysis of Variance to assess independence of decline in kittiwake numbers over time with respect to different sites.
- **Linear Regression**: Modeling trends to predict the number of breeding pairs at Site B in 2009.

### Morphological Measurements Analysis

- **Visual Summary**: Creating scatterplot matrices to understand relationships between weight, wingspan, and culmen length.
- **Independence Tests**: Examining independence of wingspan and culmen length within sub-species using scatterplots.
- **Weight Comparison**: Using Welch's t-test to compare weights between black-legged and red-legged kittiwakes.
- **Multivariate Analysis (MANOVA)**: Assessing overall differences between sub-species based on wingspan, culmen length, and weight.

### Location Data Analysis

- **Linear Models**: Fitting linear models to predict breeding pairs using environmental covariates.
- **Log Transformation**: Applying log transformation to the number of breeding pairs for better model fit.
- **Model Comparison**: Comparing linear and log-transformed models to select the best fit.
- **Confidence Intervals**: Providing an 80% confidence interval for breeding pairs at specified environmental conditions.

## Visualizations

- Histograms and QQ plots for EDA
- Box plots and scatter plots for morphological measurements
- Line plots and heplots for historical and location data analysis

## How to Use

1. **Clone the Repository**: 
   ```bash
   git clone https://github.com/ParabYash/Data-Analysis-and-Machine-Learning-Project.git
   ```

2. **Install Required Packages**: Ensure you have the necessary R packages installed:
   ```R
   install.packages(c("ggplot2", "reshape2", "car"))
   ```

3. **Run the R Script**: Open `Coursework_RFile.R` in RStudio or any R environment and run the code to replicate the analysis and visualizations.

## Contact Information

For any questions or suggestions, feel free to contact me:

- **Email**: yashparab05@gmail.com
- **LinkedIn**: [Yash Parab](https://linkedin.com/in/yash-parab-9a5a6a209)
