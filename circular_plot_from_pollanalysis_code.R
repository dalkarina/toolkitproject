#The code used for making the circular plot expressing the uses of AI
library(packcircles)
library(ggplot2)
library(dplyr)

# Original data
data <- data.frame(
  label = c(
    "Help with learning", "Writing texts", "Translating content",
    "Programming", "Generating images", "Entertainment",
    "Decision support", "Don't use AI"
  ),
  value = c(165, 91, 77, 39,42, 33, 43, 12)
)

# Total responses (sum of values)
total <- sum(data$value)

# Add percentage and combined label
data <- data %>%
  mutate(
    percentage = round(100 * value / total, 1),
    display_label = paste0(label, "\n", value, " (", percentage, "%)")
  )

# Generate circle layout
packing <- circleProgressiveLayout(data$value, sizetype = 'area')
data <- cbind(data, packing)

# Data for drawing circles
dat.gg <- circleLayoutVertices(packing, npoints = 50)

# Plot
ggplot() +
  geom_polygon(data = dat.gg, aes(x, y, group = id, fill = as.factor(id)), 
               colour = "black", alpha = 0.6) +
  geom_text(data = data, aes(x, y, label = display_label), size = 3) +
  theme_void() +
  theme(legend.position = "none") +
  ggtitle("Uses of AI (Size = Mentions, Label = Count + %)") 
