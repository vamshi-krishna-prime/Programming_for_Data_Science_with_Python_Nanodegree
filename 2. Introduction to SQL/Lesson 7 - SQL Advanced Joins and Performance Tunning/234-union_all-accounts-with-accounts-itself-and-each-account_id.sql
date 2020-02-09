/*
Programming for Data Science with Python Nanodegree
Udacity's certified program > SQL practice >
Lesson 7 : SQL Advanced JOINs and Performance Tuning

Advanced JOINs:

Section 16: Performance Tunning
*/

SELECT a.name,
       COUNT(*) AS web_events
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;
