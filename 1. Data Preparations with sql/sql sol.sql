-- Viewing data 
select*
from student_purchases;

-- Creating sql view 
-- I. Calculating a Subscription’s End Date

select
	purchase_id,
    student_id,
    plan_id,
    date_purchased as date_start,
    case
		when plan_id = 0 then date_add(date_purchased, interval 1 month)
        when plan_id = 1 then date_add(date_purchased, interval 3 month)
        when plan_id = 2 then date_add(date_purchased, interval 12 month)
	end as date_end,
    date_refunded
from student_purchases;

-- Counting total rows for sanity check 
select count(*)
from(
	select
	purchase_id,
    student_id,
    plan_id,
    date_purchased as date_start,
    case
		when plan_id = 0 then date_add(date_purchased, interval 1 month)
        when plan_id = 1 then date_add(date_purchased, interval 3 month)
        when plan_id = 2 then date_add(date_purchased, interval 12 month)
	end as date_end,
    date_refunded
from student_purchases) as sanity_check;

-- Considering refund date for new end date of subscription

select
	purchase_id,
    student_id,
    plan_id,
    date_start,
    if(date_refunded is null,
		date_end,
        date_refunded) as date_end
from(
	select
		purchase_id,
		student_id,
		plan_id,
		date_purchased as date_start,
		case
			when plan_id = 0 then date_add(date_purchased, interval 1 month)
			when plan_id = 1 then date_add(date_purchased, interval 3 month)
			when plan_id = 2 then date_add(date_purchased, interval 12 month)
            WHEN plan_id = 3 THEN NULL  -- Lifetime subscription (no end date)
		end as date_end,
		date_refunded
	from student_purchases
) a;

-- Sanity check
select count(*)
from(
	select
	purchase_id,
    student_id,
    plan_id,
    date_start,
    if(date_refunded is null,
		date_end,
        date_refunded) as date_end
from(
	select
		purchase_id,
		student_id,
		plan_id,
		date_purchased as date_start,
		case
			when plan_id = 0 then date_add(date_purchased, interval 1 month)
			when plan_id = 1 then date_add(date_purchased, interval 3 month)
			when plan_id = 2 then date_add(date_purchased, interval 12 month)
            WHEN plan_id = 3 THEN NULL  -- Lifetime subscription (no end date)
		end as date_end,
		date_refunded
	from student_purchases
) a) as sanity_check;

-- III. Creating Two ‘paid’ Columns and a MySQL View

SELECT
	*,
    CASE 
		WHEN date_end < '2021-04-01' THEN 0 
		WHEN date_start > '2021-06-30' THEN 0 
		ELSE 1 
	END AS paid_q2_2021,
	CASE 
		WHEN date_end < '2022-04-01' THEN 0 
		WHEN date_start > '2022-06-30' THEN 0 
		ELSE 1 
	END AS paid_q2_2022
FROM
(
    select
	purchase_id,
    student_id,
    plan_id,
    date_start,
    if(date_refunded is null,
		date_end,
        date_refunded) as date_end
from(
	select
		purchase_id,
		student_id,
		plan_id,
		date_purchased as date_start,
		case
			when plan_id = 0 then date_add(date_purchased, interval 1 month)
			when plan_id = 1 then date_add(date_purchased, interval 3 month)
			when plan_id = 2 then date_add(date_purchased, interval 12 month)
            WHEN plan_id = 3 THEN NULL  -- Lifetime subscription (no end date)
		end as date_end,
		date_refunded
	from student_purchases
) a
) b;
-- Drop the view if it already exists
DROP VIEW IF EXISTS purchases_info;

-- Create the new view
CREATE VIEW purchases_info AS
SELECT
    purchase_id,
    student_id,
    plan_id,
    date_start,
    date_end,
    -- Check if the subscription is active in Q2 2021
    CASE 
        WHEN date_end < '2021-04-01' OR date_start > '2021-06-30' THEN 0  -- No overlap with Q2 2021
        ELSE 1  -- Active subscription in Q2 2021
    END AS paid_q2_2021,
    -- Check if the subscription is active in Q2 2022
    CASE 
        WHEN date_end < '2022-04-01' OR date_start > '2022-06-30' THEN 0  -- No overlap with Q2 2022
        ELSE 1  -- Active subscription in Q2 2022
    END AS paid_q2_2022
FROM (
    -- Sub-query created in the task "II. Re-Calculating a Subscription's End Date"
    SELECT
        purchase_id,
        student_id,
        plan_id,
        date_purchased AS date_start,
        CASE 
            WHEN plan_id = 0 THEN DATE_ADD(date_purchased, INTERVAL 1 MONTH)
            WHEN plan_id = 1 THEN DATE_ADD(date_purchased, INTERVAL 3 MONTH)
            WHEN plan_id = 2 THEN DATE_ADD(date_purchased, INTERVAL 12 MONTH)
            WHEN plan_id = 3 THEN NULL  -- Lifetime subscription (no end date)
        END AS date_end,
        date_refunded
    FROM student_purchases
) b;

-- minutes watched by students
-- Aggregated time watched for each students

select student_id, round(sum(seconds_watched)/60, 2) as minutes_watched
from student_video_watched
group by student_id;

-- Time watched for each students in year 2022 and 2021
select student_id, sum(seconds_watched)/60 as minutes_watched
from student_video_watched
where YEAR(date_watched) = 2021 or YEAR(date_watched) = 2022
group by student_id;


-- Q2 2021 Total Minutes Watched

SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(
        MAX(i.date_start) IS NULL, 
        0, 
        MAX(i.paid_q2_2022)
    ) AS paid_in_q2
FROM 
    (
        SELECT 
            student_id, 
            SUM(seconds_watched) / 60 AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            YEAR(date_watched) = 2021 OR YEAR(date_watched) = 2022
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    purchases_info i ON a.student_id = i.student_id
GROUP BY 
    a.student_id;
    
-- Sanity check 
select count(*)
from 
	(SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(
        MAX(i.date_start) IS NULL, 
        0, 
        MAX(i.paid_q2_2022)
    ) AS paid_in_q2
FROM 
    (
        SELECT 
            student_id, 
            SUM(seconds_watched) / 60 AS minutes_watched
        FROM 
            student_video_watched
        WHERE 
            YEAR(date_watched) = 2021 OR YEAR(date_watched) = 2022
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    purchases_info i ON a.student_id = i.student_id
GROUP BY 
    a.student_id)AS SANITY_CHECK;
 
 -- Creating a ‘paid’ Column
 
SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(
        MAX(i.date_start) IS NULL, -- Aggregate function to avoid ONLY_FULL_GROUP_BY error
        0,  
        MAX(i.paid_q2_2022) -- Change to *_2021 or *_2022 as needed
    ) AS paid_in_q2 
FROM 
    (
        -- Subquery to get total minutes watched by each student in Q2 2022
        SELECT 
            student_id, 
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched 
        FROM 
            student_video_watched 
        WHERE 
            YEAR(date_watched) = 2022 -- Adjust to 2021 or 2022 depending on the analysis period
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    purchases_info i ON a.student_id = i.student_id 
GROUP BY 
    a.student_id
HAVING 
    paid_in_q2 = 0; -- Filter for students without paid subscriptions in Q2
    
SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(
        MAX(i.date_start) IS NULL, -- Aggregate function to avoid ONLY_FULL_GROUP_BY error
        0,  
        MAX(i.paid_q2_2022) -- Change to *_2021 or *_2022 as needed
    ) AS paid_in_q2 
FROM 
    (
        -- Subquery to get total minutes watched by each student in Q2 2022
        SELECT 
            student_id, 
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched 
        FROM 
            student_video_watched 
        WHERE 
            YEAR(date_watched) = 2022 -- Adjust to 2021 or 2022 depending on the analysis period
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    purchases_info i ON a.student_id = i.student_id 
GROUP BY 
    a.student_id
HAVING 
    paid_in_q2 = 1; -- Filter for students with paid subscriptions in Q2
    
SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(
        MAX(i.date_start) IS NULL, -- Aggregate function to avoid ONLY_FULL_GROUP_BY error
        0,  
        MAX(i.paid_q2_2022) -- Change to *_2021 or *_2022 as needed
    ) AS paid_in_q2 
FROM 
    (
        -- Subquery to get total minutes watched by each student in Q2 2022
        SELECT 
            student_id, 
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched 
        FROM 
            student_video_watched 
        WHERE 
            YEAR(date_watched) = 2021 -- Adjust to 2021 or 2022 depending on the analysis period
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    purchases_info i ON a.student_id = i.student_id 
GROUP BY 
    a.student_id
HAVING 
    paid_in_q2 = 0; -- Filter for students without paid subscriptions in Q1

SELECT 
    a.student_id, 
    a.minutes_watched, 
    IF(
        MAX(i.date_start) IS NULL, -- Aggregate function to avoid ONLY_FULL_GROUP_BY error
        0,  
        MAX(i.paid_q2_2022) -- Change to *_2021 or *_2022 as needed
    ) AS paid_in_q2 
FROM 
    (
        -- Subquery to get total minutes watched by each student in Q2 2022
        SELECT 
            student_id, 
            ROUND(SUM(seconds_watched) / 60, 2) AS minutes_watched 
        FROM 
            student_video_watched 
        WHERE 
            YEAR(date_watched) = 2021 -- Adjust to 2021 or 2022 depending on the analysis period
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    purchases_info i ON a.student_id = i.student_id 
GROUP BY 
    a.student_id
HAVING 
    paid_in_q2 = 1; -- Filter for students with paid subscriptions in Q2
    
    
    
-- Part 3: Data Preparation with SQL – Certificates Issued



-- Viewing the data
select * 
from data_scientist_project.student_certificates;

-- Studying Minutes Watched and Certificates Issued
SELECT 
  student_id, 
  COUNT(certificate_id) AS certificates_issued 
FROM 
  student_certificates 
GROUP BY student_id;

SELECT 
    a.student_id,
    ROUND(COALESCE(SUM(w.seconds_watched), 0) / 60, 2) AS minutes_watched,
    a.certificates_issued
FROM 
    (
        SELECT 
            student_id, 
            COUNT(certificate_id) AS certificates_issued 
        FROM 
            student_certificates 
        GROUP BY 
            student_id
    ) a 
LEFT JOIN 
    student_video_watched w ON a.student_id = w.student_id
GROUP BY 
    a.student_id;

