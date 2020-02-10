/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 13: Question Set #2

Question 3:
Finally, for each of these top 10 paying customers, I would like to find out
the difference across their monthly payments during 2007. Please go ahead and
write a query to compare the payment amounts in each successive month. Repeat
this for each of these 10 paying customers. Also, it will be tremendously
helpful if you can identify the customer name who paid the most difference in
terms of payments.
*/

WITH payment_details AS (
  SELECT c.first_name || ' ' || c.last_name AS full_name,
         DATE_TRUNC('month', p.payment_date) AS pay_month,
         DATE_PART('year', p.payment_date) AS pay_year,
         p.amount AS amount
  FROM customer c
  JOIN payment p
  ON c.customer_id = p.customer_id ),

top_customer AS (
  SELECT DISTINCT pd.full_name AS full_name,
         SUM(pd.amount) OVER(PARTITION BY pd.full_name)
  FROM payment_details pd
  ORDER BY 2 DESC
  LIMIT 10 ),

monthly_details AS (
  SELECT tc.full_name,
         pd.pay_month,
         SUM(pd.amount) AS total_monthly_pay
  FROM payment_details pd
  JOIN top_customer tc
  ON pd.full_name = tc.full_name
  GROUP BY 1, 2
  ORDER BY 1, 2)


SELECT full_name,
       pay_month,
       total_monthly_pay,
       LAG(total_monthly_pay) OVER ordered_window AS lag_value,
       (total_monthly_pay - LAG(total_monthly_pay) OVER ordered_window) AS monthly_pay_diff
FROM monthly_details
WINDOW ordered_window AS (PARTITION BY full_name ORDER BY pay_month)
ORDER BY 5 DESC NULLS LAST
LIMIT 1;

/*
IMPORTANT NOTE:

When ORDERED rows with NULL values in Descending order, NULLs are placed first
before higher values, hence in the last but one line in the above query, used
'ORDER BY 5 DESC NULLS LAST' command to send all NULL values to bottom of the
resulting table.

REFER the below link for furthur understanding:
https://stackoverflow.com/questions/26949596/how-can-i-make-null-values-be-considered-as-max-in-sql
*/

/*
Problem / Drawback:

Though the resulting solution is correct in this context, but sometimes there
may two person with the same MAX value. In the case, using LIMIT 1 will not
produce the precise solution.
*/



/*--------------------- Modified and Rectified Solution ---------------------*/
WITH payment_details AS (
  SELECT c.first_name || ' ' || c.last_name AS full_name,
         DATE_TRUNC('month', p.payment_date) AS pay_month,
         DATE_PART('year', p.payment_date) AS pay_year,
         p.amount AS amount
  FROM customer c
  JOIN payment p
  ON c.customer_id = p.customer_id ),

top_customer AS (
  SELECT DISTINCT pd.full_name AS full_name,
         SUM(pd.amount) OVER(PARTITION BY pd.full_name)
  FROM payment_details pd
  ORDER BY 2 DESC
  LIMIT 10 ),

monthly_details AS (
  SELECT tc.full_name,
         pd.pay_month,
         SUM(pd.amount) AS total_monthly_pay
  FROM payment_details pd
  JOIN top_customer tc
  ON pd.full_name = tc.full_name
  GROUP BY 1, 2
  ORDER BY 1, 2),

lag_diff AS (
  SELECT md.full_name,
         md.pay_month,
         md.total_monthly_pay,
         LAG(md.total_monthly_pay) OVER ordered_window AS lag_value,
         (md.total_monthly_pay - LAG(md.total_monthly_pay) OVER ordered_window) AS monthly_pay_diff
  FROM monthly_details md
  WINDOW ordered_window AS (PARTITION BY md.full_name ORDER BY md.pay_month)
  ORDER BY 1, 2)

SELECT *
FROM lag_diff
WHERE monthly_pay_diff = (SELECT MAX(monthly_pay_diff) FROM lag_diff);

/*
Since we used sub query to find MAX value and used it to display all rows with
the MAX values, if there were more than one row with same MAX value, all rows
with the MAX value will be displayed.

REFER the below link for furthur understanding:
https://stackoverflow.com/questions/22278769/how-to-use-max-for-multiple-occurrences-of-max-values-in-sql
*/
