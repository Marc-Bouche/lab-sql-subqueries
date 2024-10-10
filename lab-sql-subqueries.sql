USE sakila;

#Write SQL queries to perform the following tasks using the Sakila database:
#1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
#--------------------------------------------MY_ANSWER--------------------------------------------#
#INNER JOIN
SELECT title,COUNT(title) AS Copies_in_inventory
FROM film 
INNER JOIN INVENTORY USING(film_id)
WHERE title="Hunchback Impossible";

#SUBQUERRY INTENT
SELECT title
FROM film
WHERE EXISTS (
  SELECT 1
  FROM inventory
  WHERE inventory.film_id = film.film_id
  AND film.title = 'Hunchback Impossible'
);


#2.List all films whose length is longer than the average length of all the films in the Sakila database.
#--------------------------------------------MY_ANSWER--------------------------------------------#
SELECT title
FROM film
WHERE film.length > (SELECT AVG(length) FROM film);


#3.Use a subquery to display all actors who appear in the film "Alone Trip".
#--------------------------------------------MY_ANSWER--------------------------------------------#
SELECT film.title
FROM film
WHERE title='Alone Trip'(SELECT CONCAT(first_name,last_name) AS full_name FROM actor);

SELECT film.title, Actor.full_name
FROM film
JOIN actor ON actor.actor_id IN (
  SELECT film_actor.actor_id
  FROM film_actor
  WHERE film_actor.film_id = (
    SELECT film.film_id
    FROM film
    WHERE film.title = 'Alone Trip'
  )
);
