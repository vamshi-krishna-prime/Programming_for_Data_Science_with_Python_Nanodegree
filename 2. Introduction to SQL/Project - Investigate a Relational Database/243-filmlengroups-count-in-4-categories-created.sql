/*
SQL practice in Udacity's 'Programming for Data Science' Nanodegree Program
SQL > Lesson 8 > Project: Investigate the 'Sakila DVD rental database'

Section 10: Quiz 2

Question 2:

previous query: (query no 242)
(Write a query that displays a table with 4 columns: actor's full name,
film title, length of movie, and a column name "filmlen_groups" that classifies
movies based on their length. Filmlen_groups should include 4 categories:
1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

present query:
Now, we bring in the advanced SQL query concepts! Revise the query you wrote
above to create a count of movies in each of the 4 filmlen_groups:
1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

Match the count of movies in each filmlen_group:

1 hour or less
Between 1-2 hours
Between 2-3 hours
More than 3 hours
*/

/* categorize the entire dataset in a sub-query and then perform count */
WITH category AS (SELECT f.title,
                         f.length,
                         CASE WHEN f.length <= 60 THEN '1 hour or less'
                              WHEN f.length > 60 AND f.length <= 120 THEN 'Between 1-2 hours'
                              WHEN f.length > 120 AND f.length <= 180 THEN 'Between 2-3 hours'
                              WHEN f.length > 180 THEN 'More than 3 hours'
                              ELSE 'Undefined' /* To identify anamoly or NULLs*/
                              END AS filmlen_groups
                  FROM film f)

SELECT c.filmlen_groups,
       COUNT(c.title) AS film_count
FROM category c
GROUP BY 1
ORDER BY 1;

/*
Output 4 results:

filmlen_groups	        film_count
1 hour or less	           104
Between 1-2 hours	         439
Between 2-3 hours	         418
More than 3 hours	          39
*/


/*-----------Solution Provided-------------*/

SELECT    DISTINCT(filmlen_groups),
          COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencat
FROM
         (SELECT title,length,
          CASE WHEN length <= 60 THEN '1 hour or less'
          WHEN length > 60 AND length <= 120 THEN 'Between 1-2 hours'
          WHEN length > 120 AND length <= 180 THEN 'Between 2-3 hours'
          ELSE 'More than 3 hours' END AS filmlen_groups
          FROM film ) t1
ORDER BY  filmlen_groups

/*
The solution provided is more sophisticated and uses advanced approach like
COUNT window function.
*/
