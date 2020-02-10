/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Project Queries

Question:
rental counts based on film ratings
*/

WITH categories AS (
  SELECT r.rental_id,
         f.title,
         f.rating,
         p.amount
  FROM film f
  JOIN inventory i
  ON f.film_id = i.film_id
  JOIN rental r
  ON i.inventory_id = r.inventory_id
  JOIN payment p
  ON r.rental_id = p.rental_id
  ORDER BY 3, 2, 1)

SELECT DISTINCT rating,
       COUNT(rating) OVER ( PARTITION BY rating ) AS rentals,
       SUM(amount) OVER ( PARTITION BY rating ) AS gross_amount
FROM categories
ORDER BY 3 DESC;
