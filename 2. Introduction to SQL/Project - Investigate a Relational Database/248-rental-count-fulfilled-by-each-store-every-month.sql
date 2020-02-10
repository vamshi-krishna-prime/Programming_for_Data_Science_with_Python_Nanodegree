/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 13: Question Set #2

Question 1:
We want to find out how the two stores compare in their count of rental orders
during every month for all the years we have data for. Write a query that
returns the store ID for the store, the year and month and the number of
rental orders each store has fulfilled for that month. Your table should
include a column for each of the following: year, month, store ID and
count of rental orders fulfilled during that month.
*/
/*------------------Approach 1-----------------------*/
SELECT DATE_PART('year', r.rental_date) AS Rental_year,
       DATE_PART('month', r.rental_date) AS Rental_month,
       c.store_id AS Store_ID,
       COUNT(r.rental_id) AS Count_Rentals
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC;

/*------------------Approach 21-----------------------*/
SELECT DATE_PART('year', r.rental_date) AS Rental_year,
       DATE_PART('month', r.rental_date) AS Rental_month,
       s.store_id AS Store_ID,
       COUNT(r.rental_id) AS Count_Rentals
FROM rental r
JOIN staff st
ON r.staff_id = st.staff_id
JOIN store s
ON st.store_id = s.store_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC;
/* has correct solution */


/*
DOUBT:
Approach 1 and 2 has different results , WHY?
*/


WITH sub AS (SELECT DATE_PART('year', r.rental_date) AS Rental_year,
       DATE_PART('month', r.rental_date) AS Rental_month,
       s.store_id AS Store_ID,
       COUNT(r.rental_id) AS Count_Rentals
FROM rental r
JOIN staff st
ON r.staff_id = st.staff_id
JOIN store s
ON st.store_id = s.store_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC)

SELECT Rental_year,
       Rental_month,
       Store_ID,
       Count_rentals,
       SUM(Count_Rentals) OVER (ORDER BY Count_Rentals)
FROM sub;




/*
DOUBT 2:
A customer must brought from one of store, so why different count shown below:
*/

SELECT c.store_id,
	COUNT(c.store_id) AS count
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY 1
/*
1  8747
2  7297
*/

SELECT s.store_id,
	COUNT(s.store_id) AS count
FROM rental r
JOIN staff st
ON r.staff_id = st.staff_id
JOIN store s
ON st.store_id = s.store_id
GROUP BY 1
/*
1  8040
2  8004
*/

/* More detailed query */

SELECT r.rental_id,
	r.rental_date,
       c.customer_id,
       st.staff_id,
       s.store_id AS s_store_id,
       c.store_id AS c_store_id
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
JOIN staff st
ON r.staff_id = st.staff_id
JOIN store s
ON st.store_id = s.store_id
WHERE c.store_id <> s.store_id;
