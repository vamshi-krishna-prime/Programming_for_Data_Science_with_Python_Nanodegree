/*
Udacity's - 'Programming for Data Science' certified Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Q8: When does the family films rented most based on the day of the week?
*/

WITH rental_day AS (
  SELECT r.rental_id,
         f.title,
         c.name AS category,
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
      ON i.film_id = f.film_id
    JOIN film_category fc
      ON f.film_id = fc.film_id
    JOIN category c
      ON fc.category_id = c.category_id
     AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
   )

  SELECT DISTINCT rd.dow,
         COUNT(rd.rental_id) OVER (PARTITION BY rd.dow) AS rental_count
    FROM rental_day rd
ORDER BY 2 DESC;
