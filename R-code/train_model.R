############ MODEL TRAINING SETUP  ###########################
library(tidyverse)
library(ggplot2)
library(tidymodels)
library(workflows)
library(tune)
library(renv)
library(plumber)
library(keras)

## Load the data

plastic_spec <- read.csv('combined_plastic_spectra.csv')

## Split into train/test data set

set.seed(198)
plastic_spec <- plastic_spec_orig
plastic_spec_split <- initial_split(plastic_spec, prop = 3/4)  # train 75% and test 25%
plastic_spec_train <- training(plastic_spec_split)
plastic_spec_test <- testing(plastic_spec_split)

## create a cross validation version of training set for parameter tuning
plastic_spec_cv <- vfold_cv(plastic_spec_train)

# Define a recipe specifying the role of each variable and preprocessing
plastic_spec_recipe <- recipe(Plastic_type ~ Raman_Shift + Intensity, data = plastic_spec) %>%
      step_normalize(all_numeric()) %>%
      step_knnimpute(all_predictors())

plastic_spec_train_preprocessed <- plastic_spec_recipe %>%      # apply recipe to trainin data set
        prep(plastic_spec_train) %>%                            # extract the pre-processed training dataset
        juice()


###########  CREATE THE MODEL

# Specify the model using parsnip

rf_model <- 
  rand_forest() %>%                # specify that the model is a random forest 
  set_args(mtry = tune()) %>%      # specify that the `mty` parameter needs to be tuned
  set_engine('ranger', importance = 'impurity') %>%  # select the engine/package that underlies the model
  set_mode('classification')                           # choose either the continuous regression or binary classification mode

## Puttig it all together into a workflow
 rf_workflow <- workflow() %>%              # set the workflow
   add_recipe(plastic_spec_recipe) %>%      # add recipe
   add_model(rf_model)                      # add model
 
## Tune the parameters
rf_grid <- expand.grid(mtry = c(1,2,1))     # specifiy values to try
rf_tune_results <- rf_workflow %>%         #extract the results
  tune_grid(resamples = plastic_spec_cv,   # cv object
            grid = rf_grid,                 # grid of values to try
            metrics = metric_set(accuracy, roc_auc))  # metrics interested about

rf_tune_results %>%
  collect_metrics()     # print results

## finalize the workflow to select the best tuned parameter
param_final <- rf_tune_results %>%
  select_best(metric = 'accuracy')
param_final

# add the selected parameter to the workflow
rf_workflow <- rf_workflow %>%
  finalize_workflow(param_final)

## Evaluate the model on the test set
rf_fit <- rf_workflow %>%   # fit on the training set and evaluate on the training set
last_fit(plastic_spec_split)
rf_fit

test_performance <- rf_fit %>% collect_metrics()  # extracts performance of the final model

test_predictions <- rf_fit %>%
  collect_predictions()            # extracts test set predictions
test_predictions

## generate a confusion matrix
test_predictions %>% 
  conf_mat(truth = Plastic_type, estimate = .pred_class)

## generate probability plot for predictions

p <- test_predictions %>%
  ggplot() + 
  geom_density(aes(x = .pred_Orange_Fiber, fill = Plastic_type),
                          alpha = 0.5)


## extracting prediction columns with function `pull()` from purr 
test_predictions <- rf_fit %>% pull(.predictions)

###################### FITTING THE MODEL

## fitting and using the final model
final_model <- fit(rf_workflow, plastic_spec)

####################3 SAVE THE MODEL

#save_model_hdf5 (final_model, "model.h5")

## Variable importance can be extracted from the ranger object
ranger_obj <- pull_workflow_fit(final_model)$fit
ranger_obj

ranger_obj$variable.importance


