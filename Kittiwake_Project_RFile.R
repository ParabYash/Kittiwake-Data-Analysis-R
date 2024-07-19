#R Code for Kittiwake Data Analysis:
library(reshape2)
library(tidyverse)
library(heplots)
library(ggplot2)
# Question 1 
par(mfrow = c(2, 2))
data<-read.csv("Kittiwake_Observation_20538923.csv")

hist(data$dawn,xlab="Number of Kittiwakes observed at Dawn",freq=TRUE,main="Kittiwakes observed at Dawn",col = "green")   
hist(data$noon,xlab="Number of Kittiwakes observed at Noon",freq=TRUE,main="Kittiwakes observed at Noon",col = "skyblue") 
hist(data$mid.afternoon,xlab="Number of Kittiwakes observed at MidAfternoon",freq=TRUE,main="Kittiwakes observed at Mid Afternoon",col = "violet") 
hist(data$dusk,xlab="Number of Kittiwakes observed at Dusk",freq=TRUE,main="Kittiwakes observed at Dusk",col = "grey") 

noon_data <- observation_data$noon
head(noon_data)
confidence_interval <- t.test(noon_data, conf.level = 0.90)$conf.int
confidence_interval
qqnorm(noon_data, col = "darkgreen")
qqline(noon_data, col = "navy")


# Question 2 

#Task A: Assessing Independence Over Time and Sites (ANOVA)
historical_data <- read.csv("Kittiwake_Historical_20538923.csv")
historical_data
melted_data <- melt(historical_data, id.vars = "X", variable.name = "Site", value.name = "Pairs")
long_data <- reshape2::melt(historical_data, id.vars = "X", variable.name = "Site", value.name = "Pairs")
str(historical_data)
summary(historical_data)
# Performing ANOVA
anova_result <- aov(Pairs ~ Site + X, data = long_data)
summary(anova_result)
#Visualization
ggplot(melted_data, aes(x = Site, y = Pairs, fill = Site)) +
  geom_boxplot() +
  labs(title = "Breeding Pairs Distribution by Site",
       x = "Site", y = "Breeding Pairs") +
  theme_minimal()

#Task B: Estimating Breeding Pairs Using Linear Regression
model <- lm(Site.B ~ X, data = historical_data)
# Predict breeding pairs for Site B in 2009
prediction <- predict(model, newdata = data.frame(X = 2009))
print(paste("Estimated breeding pairs at Site B in 2009:", round(prediction)))
# Line plot to visualize breeding pairs over years for Site B
ggplot(melted_data, aes(x = X, y = Pairs, color = Site)) +
  geom_line() +
  labs(title = "Breeding Pairs Over Years",
       x = "Year", y = "Breeding Pairs") +
  theme_minimal()

# Question 3 

# task A
measurement_data <- read.csv("Kittiwake_Measurement_20538923.csv")
head(measurement_data)
# Visual summary
pairs(measurement_data[, 2:4], main = "Scatterplot Matrix for Measurement Data")


# Task B
names(measurement_data)
# Scatterplot for both sub-species
plot(measurement_data$Wingspan[measurement_data$Sub.species == "Black-legged"], 
     measurement_data$Culmen[measurement_data$Sub.species == "Black-legged"],
     main = "Scatterplot for Kittiwakes - Wing Span vs Culmen Length", 
     xlab = "Wing Span", ylab = "Culmen Length", pch = 16, col = "navy", 
     xlim = c(min(measurement_data$Wingspan), max(measurement_data$Wingspan)),
     ylim = c(min(measurement_data$Culmen), max(measurement_data$Culmen)))

points(measurement_data$Wingspan[measurement_data$Sub.species == "Red-legged"], 
       measurement_data$Culmen[measurement_data$Sub.species == "Red-legged"],
       pch = 16, col = "lightgreen")

legend("bottomright", legend = c("Black-legged", "Red-legged"), col = c("navy", "lightgreen"), pch = 16)


#Task C
# Welch's t-test for difference in weights between sub-species
t_test_result <- t.test(measurement_data$Weight ~ measurement_data$Sub.species)
t_test_result
# Boxplot for weight by sub-species
boxplot(Weight ~ Sub.species, data = measurement_data,
        main = "Boxplot of Weight by Sub-species",
        xlab = "Sub-species", ylab = "Weight",
        col = c("navy", "darkgreen"), names = c("Black-legged", "Red-legged"))


#Task D

# Perform MANOVA
manova_result <- manova(cbind(Wingspan, Culmen, Weight) ~ Sub.species, data = measurement_data)
manova_result
summary(manova_result, test = "Pillai")
# Create a heplot
heplot(manova_result)


# Question 4
# Task A
# Load the data
location_data <- read.csv("Kittiwake_Location_20538923.csv")
head(location_data)
# Fit a linear model
model <- lm(Breeding.pairs ~ Summer.temp + cliff.height + sandeel + Coast.direction, data = location_data)
summary(model)
fitted_values <- fitted(model)

# Create a scatterplot of observed vs. fitted values
plot(location_data$Breeding.pairs, fitted_values, 
     main = "Observed vs. Fitted Values",
     xlab = "Observed Breeding Pairs",
     ylab = "Fitted Breeding Pairs",
     pch = 16, col = "blue")

abline(a = 0, b = 1, col = "red", lty = 2)

# Add a legend
legend("topleft", legend = c("Observed vs. Fitted", "Perfect Prediction"),
       col = c("blue", "red"), pch = c(16, NA), lty = c(NA, 2))


# Task B
# Take the natural logarithm of the breeding pairs variable
location_data$log_breeding_pairs <- log(location_data$Breeding.pairs)

# Fit a linear model to the logarithm of the breeding pairs
log_model <- lm(log_breeding_pairs ~ Summer.temp + cliff.height + sandeel + Coast.direction, data = location_data)
summary(log_model)
fitted_values_log <- fitted(log_model)

# Create a scatterplot of observed vs. fitted values
plot(location_data$Breeding.pairs, exp(fitted_values_log), 
     main = "Observed vs. Fitted Values (Log-Transformed Model)",
     xlab = "Observed Breeding Pairs",
     ylab = "Fitted Breeding Pairs (Back-transformed)",
     pch = 16, col = "blue")

abline(a = 0, b = 1, col = "red", lty = 2)

# Add a legend
legend("topleft", legend = c("Observed vs. Fitted", "Perfect Prediction"),
       col = c("blue", "red"), pch = c(16, NA), lty = c(NA, 2))

# Task E
# Create a new data frame with the specified covariate values
new_data <- data.frame(
  Summer.temp = 19.3,
  cliff.height = log(3.18),  # Log-transform cliff height
  sandeel = 2.74,
  Coast.direction = "East"
)

# Predict the natural logarithm of breeding pairs
predicted_log_breeding_pairs <- predict(log_model, newdata = new_data, interval = "confidence", level = 0.80)

# Transform the confidence interval back to the original scale
confidence_interval <- exp(predicted_log_breeding_pairs[, 2:3])

# Print the 80% confidence interval
cat("80% Confidence Interval for the Number of Breeding Pairs:",
    round(confidence_interval[1], 2), "to", round(confidence_interval[2], 2))

# Create a plot with the observed vs. fitted values
ggplot() +
  geom_point(aes(x = location_data$Breeding.pairs, y = exp(fitted_values_log)), col = "blue", pch = 16) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", col = "red") +
  geom_ribbon(aes(ymin = exp(predicted_log_breeding_pairs[, 2]), 
                  ymax = exp(predicted_log_breeding_pairs[, 3]), 
                  x = location_data$Breeding.pairs),
              fill = "grey", alpha = 0.5) +
  labs(title = "Observed vs. Fitted Values (Log-Transformed Model)",
       x = "Observed Breeding Pairs",
       y = "Fitted Breeding Pairs (Back-transformed)") +
  theme_minimal()

