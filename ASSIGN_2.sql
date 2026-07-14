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


