-- SAKILA DB QUERY EXERCISES --

use Sakila;
-- Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

SELECT concat(first_name," ",last_name) AS `Actor Name`
FROM actor;

-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
SELECT actor_id AS `ID number`,
first_name AS `first name`,
last_name AS `last name`
FROM actor
WHERE first_name LIKE 'Joe';

-- Find all actors whose last name contain the letters GEN
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

-- Find all actors whose last names contain the letters "LI". This time, order the rows by last name and first name, in that order.
SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name
HAVING count(last_name) >=2;

-- The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
-- Write a query to fix the record, and another to verify the change.
-- SET SQL_SAFE_UPDATES=0;
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';
-- SET SQL_SAFE_UPDATES=1;

SELECT * FROM actor
WHERE last_name = 'WILLIAMS';

-- Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! 
-- In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Then write a query to verify your change.

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

-- Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment

SELECT first_name, last_name, sum(amount)
FROM staff s 
JOIN payment p
ON p.staff_id = s.staff_id
WHERE p.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY first_name, last_name;

-- List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT title, count(actor_id) AS number_of_actors
FROM film fi 
INNER JOIN film_actor fa
ON fi.film_id = fa.film_id
GROUP BY title;
-- HAVING count(actor_id) >= 10;

--  How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, count(i.film_id) as number_in_inventory
FROM inventory i
JOIN film f
ON f.film_id = i.film_id
GROUP BY title
HAVING title = 'Hunchback Impossible';

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have 
-- also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English

SELECT title 
FROM film
WHERE title like 'k%' OR title like 'Q%' AND language_id = 1;

-- Insert a record to represent Mary Smith renting the movie ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today. 
-- Then write a query to capture the exact row you entered into the rental table





