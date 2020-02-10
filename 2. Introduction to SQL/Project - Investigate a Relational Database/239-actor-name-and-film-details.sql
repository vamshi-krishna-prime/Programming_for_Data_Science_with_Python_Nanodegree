/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 8: Quiz 1

Question 1:

Let's start with creating a table that provides the following details:
actor's first and last name combined as full_name, film title, film description
and length of the movie.

How many rows are there in the table?
*/

SELECT (a.first_name || ' ' || a.last_name) AS full_name,
       f.title,
       f.description,
       f.length
FROM actor a
JOIN film_actor fa
ON fa.actor_id = a.actor_id
JOIN film f
ON fa.film_id = f.film_id
ORDER BY 1, 2;

/*
Output 5462 results:

full_name	  title	                  description	length
Adam Grant	Annie Identity	        A Amazing Panorama of a Pastry Chef And a Boat who must Escape a Woman in An Abandoned Amusement Park	86
Adam Grant	Ballroom Mockingbird	  A Thrilling Documentary of a Composer And a Monkey who must Find a Feminist in California	173
Adam Grant	Disciple Mother	        A Touching Reflection of a Mad Scientist And a Boat who must Face a Moose in A Shark Tank	141
Adam Grant	Fireball Philadelphia	  A Amazing Yarn of a Dentist And a A Shark who must Vanquish a Madman in An Abandoned Mine Shaft
.
.
and remaining rows
*/

/*-----------Solution Provided-------------*/

SELECT a.first_name,
       a.last_name,
       a.first_name || ' ' || a.last_name AS full_name,
       f.title,
       f.length
FROM   film_actor fa
JOIN   actor a
ON     fa.actor_id = a.actor_id
JOIN   film f
ON     f.film_id = fa.film_id
