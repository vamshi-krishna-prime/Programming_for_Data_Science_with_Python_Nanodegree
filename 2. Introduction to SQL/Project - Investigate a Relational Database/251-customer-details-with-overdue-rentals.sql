/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Project Queries

Many DVD stores produce a daily list of overdue rentals so that customers can
be contacted and asked to return their overdue DVDs.

Question:
To create such a list, search the rental table for films with a return date
that is NULL and where the rental date is further in the past than the
rental duration specified in the film table. If so, the film is overdue and
we should produce the name of the film along with the customer name and
phone number.
*/

SELECT CONCAT(customer.last_name, ', ', customer.first_name) AS customer,
       address.phone,
       film.title
FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE rental.return_date IS NULL AND rental.rental_date + film.rental_duration * INTERVAL '1 DAY' < CURRENT_TIMESTAMP
ORDER BY title
LIMIT 5;

/*----------Modified----------*/
SELECT CONCAT(customer.last_name, ' ', customer.first_name) AS customer,
       address.phone,
       film.title,
       CURRENT_TIMESTAMP - rental.rental_date AS Overdue
FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
WHERE rental.return_date IS NULL AND rental.rental_date + film.rental_duration * INTERVAL '1 DAY' < CURRENT_TIMESTAMP
ORDER BY CURRENT_TIMESTAMP - rental.rental_date DESC


/*----------Modified 2----------*/
SELECT (c.last_name || ' ' || c.first_name) AS customer,
       a.phone,
       c.email,
       f.title AS movie,
       CURRENT_TIMESTAMP - r.rental_date AS Overdue
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
JOIN address a
ON c.address_id = a.address_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
WHERE r.return_date IS NULL AND r.rental_date + f.rental_duration * INTERVAL '1 DAY' < CURRENT_TIMESTAMP
ORDER BY CURRENT_TIMESTAMP - r.rental_date DESC


/*----------Modified 3----------*/
SELECT (c.last_name || ' ' || c.first_name) AS customer,
       a.phone,
       c.email,
       f.title AS movie,
       r.rental_date,
       r.return_date,
       CURRENT_TIMESTAMP - r.rental_date AS Overdue
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
JOIN address a
ON c.address_id = a.address_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
WHERE r.return_date IS NULL AND r.rental_date + f.rental_duration * INTERVAL '1 DAY' < CURRENT_TIMESTAMP
ORDER BY CURRENT_TIMESTAMP - r.rental_date DESC;


/*----------Modified 4----------*/
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
