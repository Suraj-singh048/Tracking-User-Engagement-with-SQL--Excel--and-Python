### Part V: Data Analysis with Excel – Hypothesis Testing
**Goal**: Assess whether platform enhancements have increased student engagement by analyzing the minutes watched by both free-plan and paying students in Q2 2021 vs. Q2 2022. This section includes hypothesis testing, confidence interval calculation, and analysis of correlation between engagement metrics.

**Required CSV Files**:
- `minutes_watched_2021_paid_0_no_outliers.csv`
- `minutes_watched_2022_paid_0_no_outliers.csv`
- `minutes_watched_2021_paid_1_no_outliers.csv`
- `minutes_watched_2022_paid_1_no_outliers.csv`

---

#### Step I: Calculating Mean and Median Values
**Objective**: Understand central tendencies in `minutes_watched` for each group.

**Steps**:
1. **Load Data into Excel**: Insert each CSV file into a separate tab within the same worksheet.
2. **Calculate Mean and Median**: Use Excel’s `AVERAGE` and `MEDIAN` functions on the `minutes_watched` column for each dataset.
3. **Compare Values**: Observe if the median differs significantly from the mean and relate these differences to distribution skewness from previous plots.

---

#### Step II: Calculating Confidence Intervals
**Objective**: Find the 95% confidence intervals for the `minutes_watched` metric for each group to estimate the range of typical engagement.

**Steps**:
1. **Sample Size (n)**: Use `COUNT` to determine the number of observations.
2. **Standard Error**: Divide the standard deviation (`STDEV.S`) by the square root of `n` (`SQRT`).
3. **Margin of Error**: Multiply the critical value (for 95%, use 1.96) by the standard error.
4. **Confidence Interval**: Subtract/add the margin of error from the mean for the lower and upper bounds. Optionally, visualize using a confidence interval bar chart.

---

#### Step III: Performing Hypothesis Testing
**Objective**: Test if the minutes watched have increased from Q2 2021 to Q2 2022 for free-plan and paying students.

1. **Define Hypotheses**:
   - **Null Hypothesis**: Engagement in Q2 2021 ≥ Q2 2022 (no significant increase).
   - **Alternative Hypothesis**: Engagement in Q2 2021 < Q2 2022 (significant increase).

2. **Calculate t-Statistic**:
   - **For Free-Plan (Equal Variances)**:
     - Use a two-sample t-test formula with pooled variance.
     - Look up the critical t-value for your degrees of freedom (using a t-distribution table).
   - **For Paying Students (Unequal Variances)**:
     - Use the two-sample t-test formula assuming unequal variances.

3. **Interpret Results**:
   - Compare calculated t-statistic with critical t-value. If the t-statistic is within the rejection region, reject the null hypothesis.
   - Consider implications of Type I (false positive) and Type II (false negative) errors and their impact on business decisions.

---

#### Step IV: Correlation Analysis between Minutes Watched and Certificates Issued
**Objective**: Assess if more time spent on the platform is associated with more certificates issued.

**Steps**:
1. **Load Data**: Insert `minutes_and_certificates.csv` into Excel.
2. **Calculate Correlation**: Use Excel’s `CORREL` function to find the correlation between `minutes_watched` and `certificates_issued`.
3. **Interpret Correlation Coefficient**: A positive value suggests higher minutes watched relates to more certificates, while a negative value suggests an inverse relationship.

---

This analysis provides insights into engagement trends and helps confirm if platform changes positively impacted student usage. Continue to the next section for deeper predictive analysis.
