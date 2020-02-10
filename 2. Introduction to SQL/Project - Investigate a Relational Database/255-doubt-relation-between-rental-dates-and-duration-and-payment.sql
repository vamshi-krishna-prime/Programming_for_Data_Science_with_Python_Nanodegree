/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Project Queries

*/

SELECT r.rental_id,
       f.film_id,
       f.title,
       r.rental_date,
       r.return_date,
       f.rental_duration,
       f.rental_rate,
       p.amount,
       p.payment_date
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
ORDER BY 1, 2, 3

/*
Doubt:

1. (rental date and return date) does not match with the rental duration.
2. rental rate does not match with the payment amount for some rentals.
3. only 14596 rows are returned.
4. what is the rental duration designated in ? (months or days)
5. What does the rental rate accounted for ? (price for one month or any other)
*/
