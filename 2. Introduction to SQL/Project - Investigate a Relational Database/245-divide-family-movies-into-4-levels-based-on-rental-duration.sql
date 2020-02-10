/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 12: Question Set #1

Question 2
We want to understand more about the movies that families are watching. The
following categories are considered family movies:
Animation, Children, Classics, Comedy, Family and Music.

Question 2
Now we need to know how the length of rental duration of these family-friendly
movies compares to the duration that all movies are rented for. Can you provide
a table with the movie titles and divide them into 4 levels
(first_quarter, second_quarter, third_quarter, and final_quarter) based on the
quartiles (25%, 50%, 75%) of the rental duration for movies across all
categories? Make sure to also indicate the category that these family-friendly
movies fall into.

Note:
The data are not very spread out to create a very fun looking solution, but you
should see something like the following if you correctly split your data. You
should only need the category, film_category, and film tables to answer this
and the next questions.

HINT: One way to solve it requires the use of percentiles, Window functions,
subqueries or temporary tables.
*/

/* STEP 1: divide all movie titles into 4 levels based on rental duration*/
SELECT f.title,
       f.rental_duration,
       NTILE(4) OVER(ORDER BY rental_duration) AS levels
FROM film f;

/*
Output 1000 results:
title	        rental_duration	  levels
Zorro Ark	          3	            1
Ace Goldfinger	    3	            1
Agent Truman	      3	            1
.
.
Magnolia Forrester	4	            1
Illusion Amelie	    4	            1 --> have level 1 for duration 4 months
Duck Racer	        4	            2 --> have level 2 for duration 4 months
Dalmations Sweden	  4	            2
.
.
*/

/*
While dividing the movie titles into 4 levels based on rental duration, some
movies with rental duration of 4 months are categorized under level 1 and some
are under level 2. This is an unwanted behaviour. Same behaviour is observed for
the movies under other durations.

Remember the Note stated above: 'The data are not very spread out to create a
very fun looking solution'. The peculiar behaviour is because of this reason.
*/

/* STEP 2: Now filter only family movies and join them with levels table */

WITH quardile AS (
                  SELECT f.title,
                         f.rental_duration,
                         NTILE(4) OVER( ORDER BY f.rental_duration) AS levels
                  FROM film f
                 ),

family_movies AS (
                  SELECT f.title,
                         c.name AS category
                  FROM film f
                  JOIN film_category fc
                  ON f.film_id = fc.film_id
                  JOIN category c
                  ON fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                 )

SELECT fm.title,
       fm.category,
       q.rental_duration,
       q.levels AS standard_quartile
FROM quardile q
JOIN family_movies fm
ON q.title = fm.title

/* Output 361 results */

/*
Note: The result is not ordered by any clause, hence it may not be an exact
match to the the solution provided, but the result values are same with the
solution. Also the no.of rows are also same. But this is not the solution. 

Also CTE queries are used instead of WHERE clause, for performance optimization.
*/


/* ---------- Not the exact match to the solution: ---------- */
/* 
The above query filtered a table with all film categories and divided them
into 4 quertiles. Then made another table with only family categories and
joined them together.

The resulting table might have same number of rows with the solution but
fail to catch the approach. The resulting table compares the rental 
duration of the family movies with all films (even the films that does
not belong to the family movies). 

The solution wants us to extract the family movies first and then divide
them into 4 categories based on rental duration. The correct solution is 
shown below:
*/


/* ----------------------- Correct Soltuion -----------------------------*/

WITH family_movies AS (
                  SELECT f.title,
                         c.name AS category,
                         f.rental_duration
                  FROM film f
                  JOIN film_category fc
                  ON f.film_id = fc.film_id
                  JOIN category c
                  ON fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                 )


SELECT title,
	category,
       rental_duration,
       NTILE(4) OVER( ORDER BY rental_duration) AS standard_quartile
FROM family_movies
