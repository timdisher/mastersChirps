# # Library 
# 
# library(tidyverse)
# library(devtools)
# 
# golf_data <- tribble(
#   ~name, ~day, ~rank, 
#   "Tim", "1", 104,
#   "Chris", "1", 102,
#   "Imran", "1", 145,
#   "Jason", "1", 164, 
#   "Ryan", "1", 170,
#   # Day Two
#   "Tim", "2", 67,
#   "Chris", "2", 121,
#   "Imran", "2", 200,
#   "Jason", "2", 109, 
#   "Ryan", "2", 117
# ) 
# 
# mod1 <- glm(rank ~ day + name, data = golf_data)
# 
# ggplot(golf_data, mapping = aes(x = day, y = desc(rank), group = name, color = name)) +
#   geom_line() +
#   theme_minimal() +
#   ggtitle("Master's Pool Results") +
#   scale_color_manual(values = c("Tim" = "#006B54", "Chris" = "#DC4605", 
#                                 "Imran" = "#007298", "Jason" = "#ED8B00", 
#                                 "Ryan" = "#002F6C"))
# 
# ?scale_color_manual()
# 
# library(modelr)
# 
# golf_data_pred <- golf_data %>% 
#   add_predictions(mod1) %>% 
#   
# 
# view(golf_data_pred)
#     
# library(prout)    
# prout::crgev_palettes   
# 
# install.packages("ggimage")
# library(ggimage)
# 
# golf_data <- tribble(
#   ~name, ~day, ~rank, ~icon, 
#   "Tim", "1", 104, NA,
#   "Chris", "1", 102, NA,
#   "Imran", "1", 145, NA,
#   "Jason", "1", 164, NA,
#   "Ryan", "1", 170, NA,
#   # Day Two
#   "Tim", "2", 67, "/home/rbatten/learning-r/masterChirpsRBcalcs/masters-jacket.png",
#   "Chris", "2", 121, NA,
#   "Imran", "2", 200, NA,
#   "Jason", "2", 109, NA,
#   "Ryan", "2", 117, NA
# ) 
# 
# ggplot(golf_data, 
#        mapping = aes(x = day, y = desc(rank),
#                                 group = name)) +
#   geom_line(aes(color = name)) +
#   geom_point() +
#   theme_minimal() +
#   ggtitle("Master's Pool Results") +
#   scale_color_manual(values = c("Tim" = "#006B54", "Chris" = "#DC4605", 
#                                 "Imran" = "#007298", "Jason" = "#ED8B00", 
#                                 "Ryan" = "#002F6C")) +
#   geom_image(aes(image = icon), size = 0.05)
# 
# 
# # Masters Green to Brown
# 
# 
# 
# 
