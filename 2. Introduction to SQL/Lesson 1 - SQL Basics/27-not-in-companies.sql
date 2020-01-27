/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Use the 'accounts' table to find the account name, primary poc, and
sales rep id for all stores except Walmart, Target, and Nordstrom.
*/


SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Welmart', 'Target', 'Nordstrom');
