/*
Udacity's - 'Programming for Data Science' certified Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Q1: When does top customers paid most amount?
*/

WITH top_customers AS (
    SELECT  DISTINCT c.first_name || ' ' || c.last_name AS full_name,
            SUM(p.amount) OVER ( PARTITION BY (c.first_name || c.last_name))
      FROM  customer c
      JOIN  payment p
        ON  c.customer_id = p.customer_id
  ORDER BY  2 DESC
     LIMIT  10),

payment_details AS (
    SELECT  c.first_name || ' ' || c.last_name AS full_name,
            DATE_TRUNC('month', p.payment_date) AS pay_month,
            DATE_PART('year', p.payment_date) AS pay_year,
            p.amount
      FROM  customer c
      JOIN  payment p
        ON  c.customer_id = p.customer_id)

  SELECT  pd.pay_month,
          tc.full_name,
          COUNT(pd.amount) AS pay_count_per_month,
          SUM(pd.amount) AS pay_amount_per_month
    FROM  top_customers tc
    JOIN  payment_details pd
      ON  tc.full_name = pd.full_name
   WHERE  pd.pay_year = 2007
GROUP BY  1, 2
ORDER BY  2, 1;
