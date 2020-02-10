/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 8: Quiz 1

Question 3:

Write a query that captures the actor id, full name of the actor, and counts
the number of movies each actor has made. (HINT: Think about whether you should
group by actor id or the full name of the actor.) Identify the actor who has
made the maximum number movies.
*/

SELECT a.actor_id,
       (a.first_name || ' ' || a.last_name) AS actor_name,
       COUNT(f.title) as movies_num
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id = f.film_id
GROUP BY 2, 1
ORDER BY 3 DESC, 2;

/*
Output 200 results:

actor_id	  actor_name	      movies_num
107	        Gina Degeneres	     42
102	        Walter Torn	         41
198	        Mary Keitel          40
.
.
remaining rows
*/


/*-----------Solution Provided-------------*/

SELECT actorid, full_name,
       COUNT(filmtitle) film_count_peractor
FROM
    (SELECT a.actor_id actorid,
            a.first_name,
            a.last_name,
            a.first_name || ' ' || a.last_name AS full_name,
            f.title filmtitle
    FROM    film_actor fa
    JOIN    actor a
    ON      fa.actor_id = a.actor_id
    JOIN    film f
    ON      f.film_id = fa.film_id) t1
GROUP BY 1, 2
ORDER BY 3 DESC

/*
Solution provided is better optimized as the subquery returns less rows to
work with the main query.
*/
