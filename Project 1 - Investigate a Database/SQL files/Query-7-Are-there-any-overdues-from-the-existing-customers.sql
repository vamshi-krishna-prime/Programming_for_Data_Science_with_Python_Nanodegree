/*
Udacity's - 'Programming for Data Science' certified Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Q7: Are there any overdues from the existing customers?
*/

WITH no_return AS (
  SELECT r.rental_id,
         r.inventory_id,
         r.customer_id,
         r.rental_date,
         r.return_date
    FROM rental r
   WHERE r.return_date IS NULL)

  SELECT nr.rental_id,
         c.first_name || ' ' || c.last_name AS customer_name,
         a.phone,
         c.email,
         f.title AS movie,
         nr.rental_date,
         nr.return_date,
         CURRENT_TIMESTAMP - nr.rental_date AS overdue
    FROM no_return nr
    JOIN inventory i
      ON nr.inventory_id = i.inventory_id
    JOIN film f
      ON i.film_id = f.film_id
    JOIN customer c
      ON nr.customer_id = c.customer_id
    JOIN address a
      ON c.address_id = a.address_id
   WHERE nr.rental_date + f.rental_duration * INTERVAL '1 DAY' < CURRENT_TIMESTAMP
ORDER BY CURRENT_TIMESTAMP - nr.rental_date DESC;
