/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Using the accounts table, find all the companies whose names do not start
with 'C' and end with 's'.
*/


SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';
