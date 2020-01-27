/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Try pulling all the data from the 'accounts' table, and all the data from
the 'orders' table.
*/


SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

/*
You could also go with below:
More correct compared to above.
*/

SELECT orders.*, accounts.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
