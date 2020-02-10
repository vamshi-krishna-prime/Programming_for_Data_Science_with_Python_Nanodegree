/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 12: Question Set #1

Question 2
We want to understand more about the movies that families are watching. The
following categories are considered family movies:
Animation, Children, Classics, Comedy, Family and Music.

Question 2
Now we need to know how the length of rental duration of these family-friendly
movies compares to the duration that all movies are rented for. Can you provide
a table with the movie titles and divide them into 4 levels
(first_quarter, second_quarter, third_quarter, and final_quarter) based on the
quartiles (25%, 50%, 75%) of the rental duration for movies across all
categories? Make sure to also indicate the category that these family-friendly
movies fall into.
*/

/* How to create user defined new function(DATEDIFF) by ourself */

CREATE OR REPLACE FUNCTION DateDiff (units VARCHAR(30), start_t TIMESTAMP, end_t TIMESTAMP)
   RETURNS INT AS $$
 DECLARE
   diff_interval INTERVAL;
   diff INT = 0;
   years_diff INT = 0;
 BEGIN
   IF units IN ('yy', 'yyyy', 'year', 'mm', 'm', 'month') THEN
     years_diff = DATE_PART('year', end_t) - DATE_PART('year', start_t);

     IF units IN ('yy', 'yyyy', 'year') THEN
       -- SQL Server does not count full years passed (only difference between year parts)
       RETURN years_diff;
     ELSE
       -- If end month is less than start month it will subtracted
       RETURN years_diff * 12 + (DATE_PART('month', end_t) - DATE_PART('month', start_t));
     END IF;
   END IF;

   -- Minus operator returns interval 'DDD days HH:MI:SS'
   diff_interval = end_t - start_t;

   diff = diff + DATE_PART('day', diff_interval);

   IF units IN ('wk', 'ww', 'week') THEN
     diff = diff/7;
     RETURN diff;
   END IF;

   IF units IN ('dd', 'd', 'day') THEN
     RETURN diff;
   END IF;

   diff = diff * 24 + DATE_PART('hour', diff_interval);

   IF units IN ('hh', 'hour') THEN
      RETURN diff;
   END IF;

   diff = diff * 60 + DATE_PART('minute', diff_interval);

   IF units IN ('mi', 'n', 'minute') THEN
      RETURN diff;
   END IF;

   diff = diff * 60 + DATE_PART('second', diff_interval);

   RETURN diff;
 END;
 $$ LANGUAGE plpgsql;
 -- executing the query using the user defined function

SELECT r.rental_id,
       r.rental_date,
       r.return_date,
       DATEDIFF('day', DATE_TRUNC('day',r.rental_date), DATE_TRUNC('day', r.return_date))
FROM rental r;

/* Refer http://www.sqlines.com/postgresql/how-to/datediff for complete details
on date difference in MySQL and PostgreSQL and how user defined functions are
created in PostgreSQL */
