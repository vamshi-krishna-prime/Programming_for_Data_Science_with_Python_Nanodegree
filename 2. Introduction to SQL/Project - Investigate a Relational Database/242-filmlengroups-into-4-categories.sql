/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 10: Quiz 2

Question 1:

Write a query that displays a table with 4 columns: actor's full name,
film title, length of movie, and a column name "filmlen_groups" that classifies
movies based on their length. Filmlen_groups should include 4 categories:
1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

Match the filmlen_groups with the movie titles in your result dataset.
Academy Dinosaur
Color Philadelphia
Oklahoma Jumanji
*/

/* Step 1: categorize the entire dataset */
SELECT (a.first_name || ' ' || a.last_name) AS actor_name,
       f.title,
       f.length,
       CASE WHEN f.length <= 60 THEN '1 hour or less'
            WHEN f.length > 60 AND f.length <= 120 THEN 'Between 1-2 hours'
            WHEN f.length > 120 AND f.length <= 180 THEN 'Between 2-3 hours'
            WHEN f.length > 180 THEN 'More than 3 hours'
            ELSE 'Undefined' /* To identify anamoly or NULLs*/
            END AS filmlen_groups
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
ORDER BY 3, 2, 1;

/* Step 2: Filter the results to obtain the necessary details */
SELECT (a.first_name || ' ' || a.last_name) AS actor_name,
       f.title,
       f.length,
       CASE WHEN f.length <= 60 THEN '1 hour or less'
            WHEN f.length > 60 AND f.length <= 120 THEN 'Between 1-2 hours'
            WHEN f.length > 120 AND f.length <= 180 THEN 'Between 2-3 hours'
            WHEN f.length > 180 THEN 'More than 3 hours'
            ELSE 'Undefined' /* To identify anamoly or NULLs*/
            END AS filmlen_groups
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
WHERE f.title IN ('Academy Dinosaur', 'Color Philadelphia', 'Oklahoma Jumanji')
ORDER BY 2;

/* Step 2: optimezed using sub-query */
SELECT (a.first_name || ' ' || a.last_name) AS actor_name,
       f.title,
       f.length,
       CASE WHEN f.length <= 60 THEN '1 hour or less'
            WHEN f.length > 60 AND f.length <= 120 THEN 'Between 1-2 hours'
            WHEN f.length > 120 AND f.length <= 180 THEN 'Between 2-3 hours'
            WHEN f.length > 180 THEN 'More than 3 hours'
            ELSE 'Undefined' /* To identify anamoly or NULLs*/
            END AS filmlen_groups
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN (SELECT film_id, title, length FROM film WHERE film.title IN ('Academy Dinosaur', 'Color Philadelphia', 'Oklahoma Jumanji')) AS f
ON fa.film_id = f.film_id
ORDER BY 3, 2, 1;

/* Step 2: optimezed using sub-query and restructured for easy understanding*/
WITH f AS (SELECT film_id,
                  title,
                  length
           FROM film
           WHERE film.title IN ('Academy Dinosaur', 'Color Philadelphia', 'Oklahoma Jumanji')
          )

SELECT (a.first_name || ' ' || a.last_name) AS actor_name,
       f.title,
       f.length,
       CASE WHEN f.length <= 60 THEN '1 hour or less'
            WHEN f.length > 60 AND f.length <= 120 THEN 'Between 1-2 hours'
            WHEN f.length > 120 AND f.length <= 180 THEN 'Between 2-3 hours'
            WHEN f.length > 180 THEN 'More than 3 hours'
            ELSE 'Undefined' /* To identify anamoly or NULLs*/
            END AS filmlen_groups
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN f
ON fa.film_id = f.film_id
ORDER BY 3, 2, 1;

/*
Output 26 results:
*/


/*-----------Solution Provided-------------*/
SELECT full_name,
       filmtitle,
       filmlen,
       CASE WHEN filmlen <= 60 THEN '1 hour or less'
       WHEN filmlen > 60 AND filmlen <= 120 THEN 'Between 1-2 hours'
       WHEN filmlen > 120 AND filmlen <= 180 THEN 'Between 2-3 hours'
       ELSE 'More than 3 hours' END AS filmlen_groups
FROM
    (SELECT a.first_name,
               a.last_name,
               a.first_name || ' ' || a.last_name AS full_name,
               f.title filmtitle,
               f.length filmlen
        FROM film_actor fa
        JOIN actor a
        ON fa.actor_id = a.actor_id
        JOIN film f
        ON f.film_id = fa.film_id) t1

/*

*/
