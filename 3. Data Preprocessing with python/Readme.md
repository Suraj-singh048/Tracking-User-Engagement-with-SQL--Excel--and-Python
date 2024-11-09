### Part IV: Data Preprocessing with Python – Removing Outliers
**Goal**: Prepare clean, reliable data for analysis by identifying and removing outliers in the `minutes_watched` data across four engagement datasets. This step helps ensure that extreme values don’t distort the findings in subsequent analyses.

**Required CSV Files**:
- `minutes_watched_2021_paid_0.csv`
- `minutes_watched_2022_paid_0.csv`
- `minutes_watched_2021_paid_1.csv`
- `minutes_watched_2022_paid_1.csv`
- `minutes_and_certificates.csv`

---

#### Step I: Plotting the Distributions
**Objective**: Visualize the `minutes_watched` data for each dataset to understand its distribution and identify potential skewness.

**Steps**:
1. **Import Libraries**: Use `pandas` for data manipulation, and `matplotlib` and `seaborn` for visualization.
2. **Load Data**: Import the four CSV files into separate pandas DataFrames.
3. **Explore Data**: Use `head()` to inspect the first few rows of each dataset.
4. **Plot Distributions**: Use `kdeplot()` from `seaborn` to create four subplots showing each dataset's `minutes_watched` distribution. This visualization highlights skewed distributions and gives insight into user engagement.

---

#### Step II: Removing the Outliers
**Objective**: Filter out the top 1% of extreme `minutes_watched` values from each dataset to minimize skewed effects on analysis.

**Steps**:
1. **Calculate the 99th Percentile**: Use `quantile()` to find the 99th percentile in the `minutes_watched` column for each dataset.
2. **Filter Data**: Remove rows where `minutes_watched` exceeds this 99th percentile, keeping only the lower 99% of values.
3. **Visualize Filtered Data**: Re-plot the cleaned data to confirm the removal of outliers.
4. **Save Cleaned Data**: Save each filtered dataset as a new CSV file:
   - `minutes_watched_2021_paid_0_no_outliers.csv`
   - `minutes_watched_2022_paid_0_no_outliers.csv`
   - `minutes_watched_2021_paid_1_no_outliers.csv`
   - `minutes_watched_2022_paid_1_no_outliers.csv`

This preprocessing step ensures data consistency and prepares it for deeper analysis in subsequent parts of the project.
