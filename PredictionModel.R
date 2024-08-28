#Prediction Model

library(pROC)
library(lattice)
library(randomForest)
library(caret)
#Loading in data
setwd("...")
load("feat_relative_abundance.RData")
load("OSCC_metadata.RData")
feat.all.rela <- read.csv("~/oral_fil_rela.csv", stringsAsFactors = FALSE, header = TRUE, row.names = 1, check.names = FALSE)
#feat.all.rela <- feat.all.rela[, -c(1)]
feat.all.rela <- as.matrix(feat.all.rela)
feat.all.rela <- feat.all.rela[, meta.all$run]
t_feat_rela <- t(feat.all.rela)
dim(t_feat_rela)
print(t_feat_rela)
rownames(file_rela) <- file_rela$name
file_rela <- file_rela[, meta.all$run]
t_file_rela <- t(file_rela)
dim(t_file_rela)
 
 
dim(meta.all)
#Splitting data into training and testing
set.seed(123)
train_index <- createDataPartition(data$HNC2, p = 0.6, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]
table(train_data$HNC2)
table(test_data$HNC2)
#Training
#Set up cross-validation
train_control <- trainControl(method = "cv", number = 10)
 
#Define the grid for hyperparameter tuning
tune_grid <- expand.grid(
  .mtry = c(3, 4, 5)
)
 
set.seed(123)
#Training random forest model
tuned_model <- train(
  HNC2 ~ .,
  data = train_data, 
  method = "rf",
  trControl = train_control,
  tuneGrid = tune_grid,
  ntree = 500,
  metric = "Kappa"
)
print(tuned_model)
#Prediction
test_predictions <- predict(tuned_model, test_data)
 
#Confusion Matrix on the test set
conf_matrix <- confusionMatrix(test_predictions, test_data$HNC, positive = "yes")
print(conf_matrix)

