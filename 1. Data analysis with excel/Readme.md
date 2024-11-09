### Part I: Data Preparation with SQL 
**Goal**: To consolidate relevant data by calculating subscription end dates based on various plan durations (monthly, quarterly, annual, or lifetime). This prepares the data for tracking user engagement and assessing subscription status over time.

**Steps**:
1. Use the `student_purchases` table to create a view with subscription details.
2. Rename the `date_purchased` column as `date_start` and calculate `date_end` by adding the subscription period (1, 3, or 12 months).
3. Exclude lifetime subscriptions from `date_end` calculation, as they have no end date.
4. Verify that the resulting table has the correct number of rows for accuracy.

---

### Part II: Re-Calculating a Subscription’s End Date
**Goal**: To refine subscription end dates by considering refunds, making the dataset more accurate for engagement analysis.

**Steps**:
1. Build on the previous query by including `date_refunded` to adjust `date_end` when a refund has been issued.
2. If `date_refunded` is not null, update `date_end` to reflect the refund date.
3. Ensure consistency with the original row count to confirm that the view is correctly adjusted.

---

### Part III: Creating Two ‘paid’ Columns and a MySQL View
**Goal**: To indicate whether students had active subscriptions during the second quarters of 2021 and 2022, allowing analysis of engagement trends during these key periods.

**Steps**:
1. Use the previous result as a sub-query to build this view.
2. Create two columns, `paid_q2_2021` and `paid_q2_2022`, assigning binary values (0 or 1) based on active subscription status during the Q2 period.
3. Use conditions to check if the subscription start and end dates fall within the respective Q2 timeframes.
4. Save the result as a view (`purchases_info`) in the database for easy reference in future analysis.

---

These summaries will guide users on each part's purpose and steps without diving into the specific SQL code, keeping it clean and concise for the GitHub README.
