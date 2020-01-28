/*
Programming for Data Science with Python Nanodegree
Udacity's certified program
SQL practice > Lesson 1 : SQL Basics

Use the accounts table to find - All companies whose names contain the
string 'one' somewhere in the name.
*/


SELECT name
FROM accounts
WHERE name LIKE '%one%'
