# Data Prediction with Python - Final Steps

Congratulations! You’ve used SQL, Python, Excel, and analytical theory to work with data related to student engagement. Now, let's complete the final step of your project by applying linear regression on the dataset to predict student engagement.

**Dataset**: Use `minutes_and_certificates.csv` extracted during the Data Preparation with SQL.

## I. Creating a Linear Regression Model

### Objective
Perform linear regression to predict `certificates_issued` using `minutes_watched` as a predictor.

### Tasks
- Determine the linear equation explaining the relationship.
- Calculate the R-squared value and interpret it.
- Predict the number of certificates for a student with 1200 minutes watched (round to the nearest integer).

### Instructions

1. **Import Libraries**
   - Required libraries include `pandas`, `matplotlib`, `LinearRegression` from `sklearn.linear_model`, and `train_test_split` from `sklearn.model_selection`. Optionally, import `seaborn` for visualization.

2. **Data Import**
   - Use `read_csv()` to load the `minutes_and_certificates.csv` data into a DataFrame.

3. **Copy Data**
   - Create a copy of the original DataFrame to avoid accidental modifications.

4. **Data Preview**
   - Preview the data using the `head()` method to familiarize yourself with column names and initial rows.

5. **Define Input and Target Variables**
   - Set `minutes_watched` as the feature (input) and `certificates_issued` as the target variable.

6. **Split Data into Training and Testing Sets**
   - Split the data using an 80-20 train-test split and set `random_state=365` for consistent results.

7. **Reshape Data**
   - Reshape the input features to meet model requirements for a single-feature regression.

8. **Create and Train the Model**
   - Initialize a `LinearRegression` model instance and fit it on the training data.

9. **Obtain Linear Equation**
   - Retrieve the model's slope (`m`) and y-intercept (`b`). Use these to form the equation: `y = mx + b`.

10. **Calculate and Interpret R-squared**
    - Calculate R-squared to assess model performance.

11. **Make a Prediction**
    - Use `predict()` to estimate the certificates for a student who watched 1200 minutes.

12. **Visualization**
    - Create a scatter plot to visualize actual vs. predicted values for the test set.

---

This guide completes the last part of our project.
