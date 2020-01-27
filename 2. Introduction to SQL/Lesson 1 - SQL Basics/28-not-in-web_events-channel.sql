/*
SQL practice in Udacity's Business Analytics Nanodegree Program

Use the 'web_events' table to find all information regarding individuals who
were contacted via any method except using 'organic' or 'adwords' methods.

Hint: 'organic' or 'adwords' are listed under 'channel' column
*/


SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');
