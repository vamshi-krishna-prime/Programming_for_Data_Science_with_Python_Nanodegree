/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Use the accounts table to find - All the companies whose names start with 'C'.
*/


SELECT name
FROM accounts
WHERE name LIKE 'C%';
