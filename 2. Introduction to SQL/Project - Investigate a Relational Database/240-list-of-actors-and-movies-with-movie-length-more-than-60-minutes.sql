/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 8: Quiz 1

Question 2:

Write a query that creates a list of actors and movies where the movie length
was more than 60 minutes. How many rows are there in this query result?
*/

SELECT (a.first_name || ' ' || a.last_name) AS actor_name,
       f.title AS movie_name,
       f.length AS movie_duration
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id AND f.length > 60
ORDER BY 3 DESC, 1, 2;

/*
Output 4900 results:

actor_name	          movie_name	     movie_duration
Burt Temple	          Chicago North	        185
Cuba Allen	          Chicago North	        185
Jayne Silverstone	    Chicago North	        185
Kevin Garland	        Chicago North	        185
.
.
and remaining rows
*/


/*-----------Solution Provided-------------*/

SELECT a.first_name,
       a.last_name,
       a.first_name || ' ' || a.last_name AS full_name,
       f.title ,
       f.length
FROM   film_actor fa
JOIN   actor a
ON     fa.actor_id = a.actor_id
JOIN   film f
ON     f.film_id = fa.film_id
WHERE  f.length > 60
