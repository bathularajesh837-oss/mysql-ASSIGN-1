--1.Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
SELECT first_name,
       last_name,
       email,
       address_id,
       COUNT(*) AS duplicate_count
FROM customer
GROUP BY first_name,
         last_name,
         email,
         address_id
HAVING COUNT(*) > 1;


--2.Number of times letter 'a' is repeated in film descriptions
SELECT SUM(
    CHAR_LENGTH(description) - 
    CHAR_LENGTH(REPLACE(LOWER(description), 'a', ''))
) AS total_a_count
FROM film;

--3.Number of times each vowel is repeated in film descriptions
SELECT
SUM(LENGTH(LOWER(description))
- LENGTH(REPLACE(LOWER(description),'a',''))) AS A_Count,
SUM(LENGTH(LOWER(description))
- LENGTH(REPLACE(LOWER(description),'e',''))) AS E_Count,
SUM(LENGTH(LOWER(description))
- LENGTH(REPLACE(LOWER(description),'i',''))) AS I_Count,
SUM(LENGTH(LOWER(description))
- LENGTH(REPLACE(LOWER(description),'o',''))) AS O_Count,
SUM(LENGTH(LOWER(description))
- LENGTH(REPLACE(LOWER(description),'u',''))) AS U_Count
FROM film;

- 4. Display the payments made by each customer
--         1. Month wise
--         2. Year wise
--         3. Week wise
SELECT * FROM sakila.customer;
SELECT * FROM sakila.payment;
SELECT  c.customer_id,   c.first_name,   c.last_name,
    EXTRACT(YEAR FROM p.payment_date) AS payment_year,
    EXTRACT(MONTH FROM p.payment_date) AS payment_month,
	EXTRACT(WEEK FROM p.payment_date) AS payment_week,
    SUM(p.amount) AS total_payment
FROM sakila.customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    payment_year, 
    payment_month,
    payment_week
ORDER BY 
    c.customer_id, 
    payment_year, 
    payment_month,
    payment_week;

-- 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date


-- 6. Display number of days remaining in the current year from today.
SELECT DATEDIFF(CONCAT(YEAR(CURDATE()), '-12-31'), CURDATE()) AS days_remaining;

-- 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
SELECT
    payment_id,
    payment_date,
    CONCAT('Q', QUARTER(payment_date)) AS quarter_label
FROM payment;
