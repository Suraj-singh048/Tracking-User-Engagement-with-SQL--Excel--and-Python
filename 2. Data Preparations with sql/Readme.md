### Part I: Calculating Total Minutes Watched in Q2 2021 and Q2 2022
**Goal**: Measure user engagement by calculating total minutes watched for each student during Q2 2021 and Q2 2022. This data will support analysis of viewing trends before and after platform improvements.

**Steps**:
1. Select `student_id` from `student_video_watched`.
2. Calculate the total `minutes_watched` for each student by aggregating minutes data within each Q2 period.
3. Filter the data separately for Q2 2021 and Q2 2022 to produce two distinct tables.
4. Confirm the accuracy by verifying the row counts for each period (7,639 for Q2 2021 and 8,841 for Q2 2022).

---

### Part II: Creating a ‘paid’ Column
**Goal**: Differentiate between free and paid users during Q2 2021 and Q2 2022 to study the engagement patterns across subscriber types.

**Steps**:
1. Use the minutes-watched data from Part I as a sub-query and join it with the `purchases_info` view.
2. Add a new column, `paid_in_q2`, to indicate if a student had an active subscription in the relevant Q2 period (1 for paid, 0 for free).
3. Produce four CSV datasets:
   - **Q2 2021**: Separate tables for students with and without active subscriptions.
   - **Q2 2022**: Separate tables for students with and without active subscriptions.
4. Verify row counts for each dataset (5,334, 6,055, 2,305, and 2,786, respectively).

---

### Part III: Studying Minutes Watched and Certificates Issued
**Goal**: Investigate the relationship between course engagement (minutes watched) and student achievements (certificates issued).

**Steps**:
1. Create a sub-query to count certificates issued for each student using `student_certificates`.
2. Join this sub-query with `student_video_watched` to include `minutes_watched` for students with certificates.
3. For students without any watching record, set `minutes_watched` to 0.
4. Save the result as `minutes_and_certificates.csv` for further analysis.
5. Verify that the final table includes 658 rows.

---

These summaries outline the purpose and high-level approach for each step, helping guide users through the dataset preparations and analysis tasks.