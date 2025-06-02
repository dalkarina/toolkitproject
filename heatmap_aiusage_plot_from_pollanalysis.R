#The code in R for the plot representing the frequency of AI usage among our responders
library(ggplot2)
library(scales)

# Create the data frame
poll_results <- data.frame(
  response = c("More than once a day", "Once a day", "Few times a week", "Once a week", 
               "Few times a month", "Once a month", "Few times in a year", "Never"),
  count = c(38, 34, 73, 13, 21, 9, 5, 13)
)

# Convert response to factor to preserve order
poll_results$response <- factor(poll_results$response, 
                                levels = c("More than once a day", "Once a day", 
                                           "Few times a week", "Once a week", 
                                           "Few times a month", "Once a month", 
                                           "Few times in a year", "Never"))
total_count <- sum(poll_results$count)
poll_results$percent <- poll_results$count / total_count

# Create heatmap-style bar plot
ggplot(poll_results, aes(x = response, y = count, fill = count)) +
  geom_bar(stat = "identity") +
  scale_fill_gradient(low = "lightblue", high = "darkred") +  # Heatmap-like gradient
  geom_text(aes(label = paste0(count, "\n(", percent(percent, accuracy = 0.1), ")")), 
            vjust = 1.1, size = 3.0, color = "white") +
  labs(title = "How often do you use Artificial Intelligence?", x = "Response", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))