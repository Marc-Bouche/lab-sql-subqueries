USE sakila;

#Write SQL queries to perform the following tasks using the Sakila database:
#1.Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
#--------------------------------------------MY_ANSWER--------------------------------------------#
#INNER JOIN
SELECT title,COUNT(title) AS Copies_in_inventory
FROM film 
INNER JOIN INVENTORY USING(film_id)
WHERE title="Hunchback Impossible";
#--------------------------------------------SOLUTION--------------------------------------------#
#SUBQUERRY INTENT
SELECT *
FROM actor
WHERE actor_id IN( 
				SELECT actor_id
				FROM film_actor
				WHERE film_id IN(
								SELECT film_id
								FROM film
								WHERE title='Alone Trip'));



#2.List all films whose length is longer than the average length of all the films in the Sakila database.
#--------------------------------------------MY_ANSWER--------------------------------------------#
SELECT title, film.length
FROM film
WHERE film.length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;


#3.Use a subquery to display all actors who appear in the film "Alone Trip".
#--------------------------------------------MY_ANSWER--------------------------------------------#

SELECT CONCAT(actor.first_name,' ', actor.last_name) AS full_name
FROM actor
INNER JOIN film_actor USING (actor_id)
INNER JOIN film USING (film_id)
WHERE film.title = 'Alone Trip';



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


#Bonus:

#4.Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.


#5.Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.


#6.Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. 
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.


#7.Find the films rented by the most profitable customer in the Sakila database.
#You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.

#--------------------------------------------MY_ANSWER--------------------------------------------#
SELECT payment.amount, payment.customer_id, film.title
FROM payment
INNER JOIN rental USING(rental_id)
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
ORDER BY payment.amount DESC
LIMIT 1;

#--------------------------------------------SOLUTION--------------------------------------------#
SELECT payment.amount, payment.customer_id, film.title
FROM payment
INNER JOIN rental USING(rental_id)
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
WHERE payment.customer_id = (
  SELECT customer_id
  FROM payment
  GROUP BY customer_id
  ORDER BY SUM(amount) DESC
  LIMIT 1
);

#8.Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client. 
#You can use subqueries to accomplish this.
#--------------------------------------------MY_ANSWER--------------------------------------------#
SELECT payment.amount, AVG(payment.amount)
FROM payment
INNER JOIN rental USING(rental_id)
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id);

#--------------------------------------------SOLUTION--------------------------------------------#
SELECT payment.customer_id, SUM(payment.amount) AS total_amount_spent
FROM payment
INNER JOIN rental USING(rental_id)
INNER JOIN inventory USING(inventory_id)
INNER JOIN film USING(film_id)
GROUP BY payment.customer_id
HAVING SUM(payment.amount) > (
  SELECT AVG(SUM(payment.amount))
  FROM payment
  GROUP BY customer_id
);







