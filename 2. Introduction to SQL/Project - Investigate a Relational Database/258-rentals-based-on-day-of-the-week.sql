/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Project Queries

Question:
rentals based on day of the week

Tip:
To exract day of the week from a time stamp use the below function:
SELECT EXTRACT(DOW FROM TIMESTAMP '2001-02-16 20:38:40');
*/

WITH rental_day AS (
  SELECT r.rental_id,
         f.title,
         r.rental_date,
         CASE WHEN EXTRACT(DOW FROM r.rental_date) = 0 THEN 'sunday'
              WHEN EXTRACT(DOW FROM r.rental_date) = 1 THEN 'monday'
              WHEN EXTRACT(DOW FROM r.rental_date) = 2 THEN 'tuesday'
              WHEN EXTRACT(DOW FROM r.rental_date) = 3 THEN 'wednesday'
              WHEN EXTRACT(DOW FROM r.rental_date) = 4 THEN 'thursday'
              WHEN EXTRACT(DOW FROM r.rental_date) = 5 THEN 'friday'
              WHEN EXTRACT(DOW FROM r.rental_date) = 6 THEN 'saturday'
              ELSE 'undefined' /* TO identify NULLs and anomaly*/
              END AS dow
  FROM rental r
  JOIN inventory i
  ON r.inventory_id = i.inventory_id
  JOIN film f
  ON i.film_id = f.film_id)

SELECT DISTINCT rd.dow,
       COUNT(rd.rental_id) OVER (PARTITION BY rd.dow) AS rental_count
FROM rental_day rd
ORDER BY 2 DESC;
