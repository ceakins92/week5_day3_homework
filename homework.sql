-- List all customers that live in Texas:

SELECT *
FROM address
WHERE district = 'Texas';

SELECT concat(first_name, ' ', last_name) AS full_name, district
FROM address AS addy
JOIN customer AS c
ON addy.address_id = c.address_id
WHERE district = 'Texas'; 


-- Get all payments above $6.99 with the customer's full name

SELECT concat(first_name, ' ', last_name), amount
FROM payment AS p
JOIN customer AS c
ON p.customer_id = c.customer_id
WHERE amount > 6.99;


-- Show all customers names who have made payments over $175

SELECT concat(first_name, ' ', last_name) AS full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING sum(amount) > 175
);


-- List all customers tha live in Napal, using city table

SELECT concat(first_name, ' ', last_name) AS full_name, country
FROM city
JOIN address AS a
ON city.city_id = a.city_id
JOIN customer AS cust
ON a.address_id = cust.address_id
JOIN country AS co
ON city.country_id = co.country_id
WHERE country = 'Nepal';


-- Which staff member had the most transactions?
-- Answer: Jon Stephens, 7,304
SELECT concat(first_name, ' ', last_name) AS full_name, count(payment_id)
FROM payment AS p
JOIN staff AS s
ON p.staff_id = s.staff_id
GROUP BY concat(first_name, ' ', last_name);


-- How many movies of each rating are ther?

SELECT rating, count(film_id)
FROM film
GROUP BY rating;


-- Show all customers who have made a single payment above 6.99
-- using subqueries

SELECT *
FROM payment;

SELECT concat(first_name, ' ', last_name)
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
);


-- How many free rentals did our store give away?

SELECT amount, count(amount)
FROM payment
GROUP BY amount
HAVING amount = 0;
