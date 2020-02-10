/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Project Queries

Question:
most popular actors based on rentals and income generated
*/

/* ------------ Top 10 popular actors --------------*/
WITH actors AS (
  SELECT a.first_name || ' ' || a.last_name AS actor,
         p.amount
  FROM actor a
  JOIN film_actor fa
  ON a.actor_id = fa.actor_id
  JOIN film f
  ON fa.film_id = f.film_id
  JOIN inventory i
  ON f.film_id = i.film_id
  JOIN rental r
  ON i.inventory_id = r.inventory_id
  JOIN payment p
  ON r.rental_id = p.rental_id)

SELECT DISTINCT actor,
       COUNT(actor) OVER (PARTITION BY actor) AS rental_count,
       SUM(amount) OVER (PARTITION BY actor) AS income_generated
FROM actors
ORDER BY 3 DESC, 2 DESC, 1
LIMIT 10;

/*
actor                 rental_count income_generated
"Susan Davis"	            750	        3193.49
"Gina Degeneres"	        685	        3129.17
"Matthew Carrey"	        619	        2543.78
"Mary Keitel"	            607	        2426.92
"Scarlett Damon"	        519	        2403.81
"Walter Torn"	            584	        2403.18
"Henry Berry"	            564	        2392.36
"Christian Akroyd"	      504	        2378.97
"Angela Witherspoon"	    589	        2357.11
"Cameron Zellweger"	      507	        2322.94
*/
