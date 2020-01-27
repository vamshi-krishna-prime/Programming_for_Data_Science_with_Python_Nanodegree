/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Use the accounts table to find:
All companies whose names do not contain the string 'one' somewhere in the name.
*/


SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';
