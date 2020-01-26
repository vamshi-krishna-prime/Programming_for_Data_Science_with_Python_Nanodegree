/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Pulls the first 10 rows and all columns from the orders table that have a
total_amt_usd less than 500.
*/

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;
