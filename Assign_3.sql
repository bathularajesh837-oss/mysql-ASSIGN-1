-- Q1. Display all customer details who have made more than 5 payments.
SELECT *
FROM customer c
WHERE c.customer_id IN (
    SELECT p.customer_id
    FROM payment p
    GROUP BY p.customer_id
    HAVING COUNT(*) > 5
);

-- Q2. Find the names of actors who have acted in more than 10 films.
SELECT first_name, last_name
FROM actor a
WHERE a.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    GROUP BY fa.actor_id
    HAVING COUNT(*) > 10
);

--Q3. Find the names of customers who never made a payment.
SELECT first_name, last_name
FROM customer c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM payment
);

-- Q4. List all films whose rental rate is higher than the average
--     rental rate of all films.
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate) FROM film
);

Q5. List the titles of films that were never rented.
SELECT f.title
FROM film f
WHERE f.film_id NOT IN (
    SELECT i.film_id
    FROM inventory i
    JOIN rental r ON r.inventory_id = i.inventory_id
);

-- Q6. Display the customers who rented films in the same month
--     as customer with ID 5.
CREATE VIEW customers_same_month_as_cust5 AS
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, MONTHNAME(r.rental_date) AS rental_month
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE MONTH(r.rental_date) IN (
    SELECT DISTINCT MONTH(rental_date)
    FROM rental
    WHERE customer_id = 5
);

SELECT * FROM customers_same_month_as_cust5;

-- Q7. Find all staff members who handled a payment greater than the
--     average payment amount.
CREATE VIEW staff_above_avg_payment AS
SELECT DISTINCT s.staff_id, s.first_name, s.last_name, p.payment_id, p.amount
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE p.amount > (SELECT AVG(amount) FROM payment);

SELECT * FROM staff_above_avg_payment;


 -- Q8. Show the title and rental duration of films whose rental
--  duration is greater than the average.
WITH avg_duration AS (
    SELECT AVG(rental_duration) AS avg_rental_duration
    FROM film
)
SELECT f.title, f.rental_duration
FROM film f
CROSS JOIN avg_duration a
WHERE f.rental_duration > a.avg_rental_duration;


-- Q9. Find all customers who have the same address as customer with ID 1.
WITH cust1_address AS (
    SELECT address_id FROM customer WHERE customer_id = 1
)
SELECT c.customer_id, c.first_name, c.last_name, c.address_id
FROM customer c, cust1_address ca
WHERE c.address_id = ca.address_id;


-- Q10. List all payments that are greater than the average of all payments.
DROP PROCEDURE IF EXISTS GetPaymentsAboveAverage;
DELIMITER $$
CREATE PROCEDURE GetPaymentsAboveAverage()
BEGIN
    SELECT payment_id, customer_id, staff_id, amount, payment_date
    FROM payment
    WHERE amount > (SELECT AVG(amount) FROM payment);
END$$ 
DELIMITER ;
-- Call the procedure:
CALL GetPaymentsAboveAverage();

 
