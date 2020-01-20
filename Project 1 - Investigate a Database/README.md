# Investigate a Database
In this project, investigated a relational database - SAKILA DVD rental database, while working with PostgreSQL. Completed the entire data analysis process, starting by posing a question, running appropriate SQL queries to answer the questions, and finishing by sharing the findings.
[Sakila dvd database](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-sample-database/) - Download the database from here

## The Aim of the project:
+ To Learn SQL fundamentals such as JOINs, Aggregations, and Subqueries. 
+ To LearnSQL advanced topics such as advanced JOINs, Data cleaning, Performance tuning and Window functions.
+ To Learn how to use SQL to answer complex business problems.

## Technologies Used:
+ **Postgre SQL**
    > Used Postgre SQL 12 and pgAdmin 4 tool to analyze the database and execute appropriate SQL queries to answer the posed questions.

+ **Visual Studio Code**
    > Used to make exploratory analysis and write appropriate SQL queries to answer the posed questions.

+ **Tableau**
    > Used to create visuals based on the tables generated from executing the queries

+ **Git Version Control**
    > Used to control and record the project files. Shared the work on GitHub profile.

### Project Rubric

The project must meet all the requirements mentioned in the rubric for the submission to pass.

#### **Queries**

| CRITERIA | MEETS SPECIFICATIONS |
| ------ | ------ |
| The student can write error-free SQL queries. | All SQL queries run without errors and produce the intended results. |
| The student can use JOINs correctly in SQL queries. | Each SQL query needs to include one or more explicit JOINs. The JOIN or JOINs should be necessary to the query. If a question does not require a JOIN please change the question to be one that does. |
| The student can use aggregations correctly in SQL queries. | Each SQL query needs to include one or more aggregations. This could be a COUNT, AVG, SUM, or other aggregation. |
| The student can use subqueries and Common Table Expressions. | At least 2 of the 4 SQL queries need to include either a subquery OR a CTE. |
| The student can use Window Functions. | At least 1 of the 4 queries should use a Window Function. |
| The SQL queries are well formatted. | The SQL queries are well formatted and use aliases. |

#### **Presentation**

| CRITERIA | MEETS SPECIFICATIONS |
| ------ | ------ |
| The student’s slides are organized well and are easy to read and understand. | Each slide should have a question and an appropriate visualization descriptions to address the question. The slides should be free of significant factual, spelling and grammatical mistakes. |
| The student can create data visualizations that provide useful information. | All visualizations should make logical sense and provide accurate analysis based on their query results. |
| The student can format data visualizations clearly and make good use of labeling. | Each SQL query needs to include one or more aggregations. This could be a COUNT, AVG, SUM, or other aggregation. |
| The student can use subqueries and Common Table Expressions. | All visualizations include a title and axis labels, have a legend where applicable, and are easily understood.Every visualization should have: chart title, x axis title, x axis label, y axis title, y axis labels |

#### **Suggestions to Make the Project Stand Out!**

| Submission Phase, Reviewer Tips | 
| ------------ |
| Look for interesting patterns and insights in the data rather than simply providing summary statistics. | |
| Use other advanced SQL functions, such as the CASE function, DATE functions; as well as other SQL data cleaning functions, such as the CONCAT function. |  |
| Use a combination of Window functions, CTE and/or subqueries in your SQL queries. |  |
| Make good use of color, size, and shape in your visualizations. |  |
| Use the slide title and/or chart description on each slide to state the key insight of the visualization. |  |


## Queries & Insights:
+ **Query 1** - When does top customers paid most amount?

```INSIGHT: The highest payments from top customers are received in April, 2007 followed by March, 2007. However there is a significant drop in the payments after March, 2007. This might be the result of either excess payments from customers or lack of resources that meet the customers taste.```

+ **Query 2** - Where should the customer accquisition funds should be spent to increase the rentals?

```INSIGHT: The graph depicts the geographical spred out of the rentals over various countries. It can be observed that both India and China are the leading counties in terms of number of rentals, followed by Russia, United States and Brazil. Hence the customer accquisition costs must be cut in there regions and should be directed to other regions with low rentals and high population like Africa Canada and Europe.```

+ **Query 3** - Which films generate most income based on ratings?

```INSIGHT: The films with PG-13 generated most income compared to films with different rating. However, it can be determined that the difference in income generated by films, based on the ratings are slim and can be overlooked. Since the ratings are not the most influencing factors in the income generation, other factors must have been playing a prominent role.```

+ **Query 4** - What are the most influencing factors in income generation?

```INSIGHT: The graph depicts that the films with duration ‘Between 1-2 hours’ and ‘Between 2-3 hours’ are more likely to get rented by the customers. In turn, categories apart from ‘family category’, generate more income compared to ‘family categories’. This concludes that the film category and its duration plays a prominent role in income generation.```

+ **Query 5** - What influences the income generated by any actor?

```INSIGHT: The graph reflects that the relation between, the number of times a dvd has been rented and income generated from it is a clear linear equation with a positive slope. This evaluates to the conclusion that the income generated by each actor is directly proportional to his popularity in having his films rented more frequent. This can be observed in the graph that some actors generate more income compared to less popular actors.```

+ **Query 6** - Who are the actors that generate most income?

```INSIGHT: The resulting table is the list of top 10 actors that generate most income compared to other actors. Among them Susan Degeneres is the most popular actor generating a highest income of 3193.49 dollars. It can also be observed that some actors generate more income even when their films are rented comparatively less frequent. Scarlett Damon and Christian Akroyd are a good example for this occurrence.```

+ **Query 7** - Are there any overdues from the existing customers?

```INSIGHT: A total of 180 overdues were detected from the existing customers. The graph diaplays the list of customers with overdues along with their contact information and data related to their rentals as in the film rented, rental date and overdue count in days. The contact information of the customers is highly useful in the retrival of the rented dvd’s.```

+ **Query 8** - When does the family films rented most based on the day of the week?

```INSIGHT: (Family films include below categories : Animation, Children, Classics, Comedy, Family and Music). From the graph, it can be observed that the rentals of family films increase at the beginning of weekend and decline as the days go by. It can also be observed that the most rentals occur on the Tuesday despite not being the weekend.```


## Tableau Links:

* Query 1:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Book52-sakila-top-customers-monthly-payment-activity/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Book52-sakila-top-customers-monthly-payment-activity/Sheet1) 


* Query 2:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight2-customers-distributed-over-geography/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight2-customers-distributed-over-geography/Sheet1) 


* Query 3:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight3-income-generated-based-on-film-ratings/Dashboard1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight3-income-generated-based-on-film-ratings/Dashboard1) 


* Query 4:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight4-income-generated-based-on-film-length-and-category/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight4-income-generated-based-on-film-length-and-category/Sheet1) 


* Query 5:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight5-income-generated-based-on-actors/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight5-income-generated-based-on-actors/Sheet1)


* Query 6:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight6-most-popular-actors-based-on-rentals-and-income-generated/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight6-most-popular-actors-based-on-rentals-and-income-generated/Sheet1)


* Query 7:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight7-customer-details-with-overdue-rentals/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight7-customer-details-with-overdue-rentals/Sheet1)


* Query 8:  [https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight8-rentals-of-family-films-based-on-day-of-the-week/Sheet1](https://public.tableau.com/profile/vamshi.krishna.prime#!/vizhome/Sakila-insight8-rentals-of-family-films-based-on-day-of-the-week/Sheet1)



## Acknowledgement:

Thanks to the [Udacity](https://www.udacity.com/) platform for providing the [Programming for Data Science with Python Nanodegree](https://www.udacity.com/course/programming-for-data-science-nanodegree--nd104) program.
