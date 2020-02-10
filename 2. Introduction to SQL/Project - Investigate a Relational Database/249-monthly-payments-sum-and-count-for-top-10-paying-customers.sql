/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 13: Question Set #2

Question 2:
We would like to know who were our top 10 paying customers, how many payments
they made on a monthly basis during 2007, and what was the amount of the
monthly payments. Can you write a query to capture the customer name,
month and year of payment, and total payment amount for each month by these
top 10 paying customers?

Check your Solution:
The following table header provides a preview of what your table should look
like. The results are sorted first by customer name and then for each month.
As you can see, total amounts per month are listed for each customer.

HINT: One way to solve is to use a subquery, limit within the subquery, and
use concatenation to generate the customer name.
*/

/*--------------------------- Correct Solution ------------------------------*/
WITH top_customers AS (
  SELECT DISTINCT c.first_name || ' ' || c.last_name AS full_name,
         SUM(p.amount) OVER ( PARTITION BY (c.first_name || c.last_name))
  FROM customer c
  JOIN payment p
  ON c.customer_id = p.customer_id
  ORDER BY 2 DESC
  LIMIT 10),

payment_details AS (
  SELECT c.first_name || ' ' || c.last_name AS full_name,
         DATE_TRUNC('month', p.payment_date) AS pay_month,
         DATE_PART('year', p.payment_date) AS pay_year,
         p.amount
  FROM customer c
  JOIN payment p
  ON c.customer_id = p.customer_id)


SELECT pd.pay_month,
       tc.full_name,
       COUNT(pd.amount) AS pay_count_per_month,
       SUM(pd.amount) AS pay_amount_per_month
FROM top_customers tc
JOIN payment_details pd
ON tc.full_name = pd.full_name
WHERE pd.pay_year = 2007
GROUP BY 1, 2
ORDER BY 2, 1;

/*
Output 34 results

Note:
You cannot use WINDOW funtions in the main query to calculate COUNT and SUM
calculations, as there are grouped by more than one category. If you use
WINDOW functions then the result will have runnig_count and running_sum
instead of COUNT and SUM. See the below quey for reference, the result is
not a correct solution as it contains running_count and running_sum.
*/

/*----------------- Incorrect Solution, only for reference ------------------*/
WITH top_customers AS (
  SELECT DISTINCT c.first_name || ' ' || c.last_name AS full_name,
         SUM(p.amount) OVER ( PARTITION BY (c.first_name || c.last_name))
  FROM customer c
  JOIN payment p
  ON c.customer_id = p.customer_id
  ORDER BY 2 DESC
  LIMIT 10),

payment_details AS (
  SELECT c.first_name || ' ' || c.last_name AS full_name,
         DATE_TRUNC('month', p.payment_date) AS pay_month,
         DATE_PART('year', p.payment_date) AS pay_year,
         p.amount
  FROM customer c
  JOIN payment p
  ON c.customer_id = p.customer_id)


SELECT DISTINCT pd.pay_month,
       tc.full_name,
       COUNT(pd.amount) OVER (PARTITION BY tc.full_name ORDER BY pd.pay_month) AS pay_count_per_month,
       SUM(pd.amount) OVER (PARTITION BY tc.full_name ORDER BY pd.pay_month) AS pay_amount_per_month
FROM top_customers tc
JOIN payment_details pd
ON tc.full_name = pd.full_name
WHERE pd.pay_year = 2007
ORDER BY 2, 1;
/*
Output 34 results
but with running_count and running_sum instead of COUNT and SUM
*/

/* Peer Query Approach 1*/
SELECT DATE_TRUNC('month', p.payment_date) AS pay_mon,
       CONCAT (c.first_name, ' ', c.last_name),
       COUNT(payment_id) AS month_count
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY 1, 2, p.customer_id
HAVING p.customer_id in (SELECT id 
                        FROM(
                            SELECT customer_id id,
                                   sum(amount) payment_sum
                            FROM payment
                            GROUP BY 1
                            ORDER BY 2 DESC
                            LIMIT 10
                            ) t1
                        )
ORDER BY 2, 1


/* Peer Query Approach 1*/
SELECT DATE_TRUNC('month', p.payment_date) AS pay_mon, 
  CONCAT (c.first_name, ' ', c.last_name) AS full_name, 
  COUNT(payment_id) AS month_count
FROM (
  SELECT customer_id, 
  SUM(amount) payment_sum
  FROM payment
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 10) t1
JOIN payment p
ON t1.customer_id = p.customer_id
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY 1, 2
ORDER BY 2, 1
