/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Project Queries

Question:
income generated based on actors
*/

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
ORDER BY 3 DESC, 2 DESC, 1;
