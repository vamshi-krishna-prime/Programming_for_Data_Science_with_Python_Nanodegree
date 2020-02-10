/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 12: Question Set #1

Question 1
We want to understand more about the movies that families are watching.
The following categories are considered family movies:
Animation, Children, Classics, Comedy, Family and Music.

Create a query that lists each movie, the film category it is classified in,
and the number of times it has been rented out.

Extra tip:
For this query, you will need 5 tables:
Category, Film_Category, Inventory, Rental and Film.

Your solution should have three columns:
Film title, Category name and Count of Rentals.
*/

/* Step 1: Categorize family movies */
SELECT f.title,
       c.name AS category
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')

/* Output 361 results:
title	                category
Chamber Italian	      Music
Grosse Wonderful	    Music
African Egg	          Family
Airplane Sierra	      Comedy
*/


/* Step 2: Categorize family movies and join rental history*/
SELECT f.title,
       c.name AS category
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id

/*
Output 5917 results:
title	             category
Freaky Pocus	     Music
Graduate Lord	     Children
Idols Snatchers	   Children
Mystic Truman	     Comedy
*/


/* Step 3: Implement COUNT*/
WITH family_category AS (SELECT f.title,
                                c.name AS category
                        FROM film f
                        JOIN film_category fc
                        ON   f.film_id = fc.film_id
                        JOIN category c
                        ON   fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                        JOIN inventory i
                        ON   f.film_id = i.film_id
                        JOIN rental r
                        ON   i.inventory_id = r.inventory_id
                        )

SELECT DISTINCT title,
       category,
       COUNT(title) OVER(PARTITION BY title) AS times_rented
FROM family_category
ORDER BY 2, 1;

/*
Note: ORDER BY 2, 1; is used to match the solution provided.
*/

/*--------------------------------*/

/* Another simple approach with less cost/time*/
WITH family_category AS (SELECT f.title,
                                c.name AS category
                        FROM film f
                        JOIN film_category fc
                        ON   f.film_id = fc.film_id
                        JOIN category c
                        ON   fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                        JOIN inventory i
                        ON   f.film_id = i.film_id
                        JOIN rental r
                        ON   i.inventory_id = r.inventory_id
                        )

SELECT title,
       category,
       COUNT(*) AS times_rented
FROM family_category
GROUP BY 1, 2
ORDER BY 2, 1;

/*--------------------------------*/

/* A fellow student from Udacity wrote the following query: */
WITH fam_film AS( SELECT f.film_id,
                         f.title AS film_title,
                         c.name AS category_name
                  FROM film AS f
                  JOIN film_category AS fc
                  ON f.film_id = fc.film_id
                  JOIN category AS c
                  ON c.category_id = fc.category_id
                  WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music') )

SELECT fam_film.film_title,
       fam_film.category_name,
       COUNT(r.rental_id)
FROM fam_film
JOIN inventory AS i
ON fam_film.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY 1, 2
ORDER BY 2, 1
/* This is one type of approach but not idle */

/*--------------------------------*/

/* If wanted to find rental count of movies under both family_category movies
and other_category movies, see the below query: */

SELECT CASE WHEN c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
            THEN 'family_category'
            WHEN c.name NOT IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
            THEN 'other_category'
            END AS group_category,
       c.name AS category,
       f.title,
       COUNT(f.title) AS movie_count
FROM film f
JOIN film_category fc
ON   f.film_id = fc.film_id
JOIN category c
ON   fc.category_id = c.category_id
JOIN inventory i
ON   f.film_id = i.film_id
JOIN rental r
ON   i.inventory_id = r.inventory_id
GROUP BY 1, 2, 3
ORDER BY 1 DESC, 2, 3;
