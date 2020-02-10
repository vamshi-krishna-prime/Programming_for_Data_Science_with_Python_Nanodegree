/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 12: Question Set #1

Question 3
Finally, provide a table with the family-friendly film category, each of the
quartiles, and the corresponding count of movies within each combination of
film category for each corresponding rental duration category. The resulting
table should have three columns:
Category, Rental length category(quartile), Count

HINT: The Count column should be sorted first by Category and then by
Rental Duration category. One way to solve this question requires the use of
Percentiles, Window functions and Case statements.

Note:
The data are not very spread out to create a very fun looking solution, but you
should see something like the following if you correctly split your data. You
should only need the category, film_category, and film tables to answer this
question.
*/

/* STEP 1: divide all movie titles into 4 levels based on rental duration*/
SELECT f.title,
       f.rental_duration,
       NTILE(4) OVER( ORDER BY f.rental_duration) AS levels
FROM film f

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

SELECT fm.category,
       q.levels AS standard_quartile,
       COUNT(*)
FROM quardile q
JOIN family_movies fm
ON q.title = fm.title
GROUP BY 1, 2
ORDER BY 1, 2;

/*
Note: The result does not match with the solution.
*/

/*------------------Solution that matches the result----------------------*/

WITH family_movies AS (
                  SELECT f.title,
                         c.name AS category,
                         f.rental_duration,
                         NTILE(4) OVER( ORDER BY f.rental_duration) AS levels
                  FROM film f
                  JOIN film_category fc
                  ON f.film_id = fc.film_id
                  JOIN category c
                  ON fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                 )

SELECT fm.category,
       fm.levels AS standard_quartile,
       COUNT(*)
FROM family_movies fm
GROUP BY 1, 2
ORDER BY 1, 2;

/*
Even though the solution matches the result, the quartiles are divided only for
the categories under the family movies (unlike question 2 where quartiles are
divided based on all categories). 
*/
