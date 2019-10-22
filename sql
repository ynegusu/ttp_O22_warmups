-- DEBUGGING CODE IS A VERY IMPORTANT SKILL

-- Right out of this program, you're hired as a mid-level data analyst. So the
-- junior analysts come to you with problems! They just can't get the code to 
-- run! Fix all the error in each query to make it run, AND runs properly!

-- DON'T LOOK AT PREVIOUS WARMUPS! TRY TO DO ON YOUR OWN.

-- hint: Try to run parts of the query to see if they run at all. And don't 
-- forget to check the error message. They ARE actually helpful sometimes.


-- hint: 3 kinds of errors, all in the CASE WHEN STATEMENT
WITH with_holiday AS (
SELECT title, description, rental_rate,
	CASE
	WHEN title iLIKE '%halloween%' OR description iLIKE '%halloween%' THEN 'Halloween' 
	WHEN title iLIKE '%christmas%' OR description iLIKE '%christmas%' THEN 'Christmas' 
	WHEN title iLIKE '%valentine%' OR description iLIKE '%valentine%' THEN 'Valentines_Day' 
	ELSE '' 
FROM film
ORDER BY holiday DESC, title)
SELECT holiday ,
	CASE
	WHEN holiday = '' THEN rental_rate
	ELSE ROUND(rental_rate/2, 2)
	END as promo
FROM film;


-----------------------------------


--hint: 4 errors total
WITH lowest_rate AS (
SELECT DISTINCT rental_rate
FROM film
ORDER by rental_rate
LIMIT 1
)
rate_next_above_1 AS (
SELECT DISTINCT rental_rate
FROM film
WHERE rental_rate > 1
ORDER by rental_rate
LIMIT 1
)

SELECT title, rental_rate,
	CASE
	WHEN rental_rate = (SELECT FROM lowest_rate) THEN 0.10 
	WHEN rental_rate = (SELECT FROM rate_next_above_1) THEN 1 
	END AS new_rate
FROM film
WHERE rating = 'PG-13';


---------------------------

-- hint: 3 errors
WITH top_actor AS (
SELECT a.actor_id, COUNT(*)
FROM film_actor as fa
	JOIN film as f ON fa.film_id=f.film_id
	JOIN actor as a ON fa.actor_id=a.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(*) DESC) 
,
films_list AS (
SELECT f.film_id, fa.actor_id
FROM film as f
JOIN film_actor as fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (SELECT actor_id FROM top_actor)
)

SELECT DISTINCT fa.actor_id, a.first_name + a.last_name as name -- || ' ' ||
FROM film as f
	JOIN film_actor as fa ON f.film_id=fa.film_id
	JOIN actor as a ON a.actor_id=fa.actor_id
WHERE f.film_id IN (SELECT film_id FROM films_list) AND
WHERE fa.actor_id != (SELECT actor_id FROM top_actor); 
  
  
  
-- BONUS ROUND! Go through again, this time there's new errors!
-- hint: 3 errors
WITH with_holidays AS (
SELECT title, description, rental_rate 
	CASE
	WHEN titel ILIKE '%halloween%' OR description ILIKE '%halloween%' THEN 'Halloween' 
	WHEN title ILIKE '%christmas%' OR description ILIKE '%christmas%' THEN 'Christmas'
	WHEN title ILIKE '%valentine%' OR description ILIKE '%valentine%' THEN 'Valentines Day'
	ELSE ''
	END 
FROM film
ORDER BY holiday DESC, title)
SELECT *,
	CASE
	WHEN holiday = '' THEN rental_rate
	ELSE ROUND(rental_rate/2, 2)
	END as promo
FROM with_holidays;



--hint: 3 types of errors (4 errors total)

SELECT DISTINCT rental_rate as lowest_rate
FROM film


SELECT DISTINCT rental_rate as lowest_rate
FROM film
ORDER by rental_rate
LIMIT 1

, 
SELECT DISTINCT rental_rate AS next_above_rate
FROM film
HAVING rental_rate > 1 
ORDER by rental_rate
LIMIT 1


SELECT title, rental_rate,
	CASE
	when rental_rate = (SELECT * FROM lowest_rate) THEN 0.10 
	when rental_rate = (SELECT * FROM rate_next_above_1) THEN 1 
	ELSE rental_rate
	END AS new_rate
FROM film
WHERE rating ilike '%PG-13%'; 



--hint: 3 errors, 2 are the same type
WITH top_actor AS (
SELECT a.actor_id, COUNT(*)
FROM film_actor as fa
	JOIN film as f ON fa.film_id=f.film_id
	JOIN actor as a ON fa.actor_id=a.actor_id
ORDER BY COUNT(*) DESC
GROUP BY a.actor_id  
LIMIT 1)
,
films_list AS (
SELECT f.film_id, fa.actor_id
FROM film as f
JOIN film_actor as fa ON f.film_id = fa.film_id
WHERE fa.actor_id = (SELECT actor_id FROM top_actor)
)

SELECT DISTINCT fa.actor_id, a.first_name||' '||a.last_name as name
FROM film as f
	JOIN film_actor as fa 
	JOIN actor as a 
WHERE f.film_id IN (SELECT film_id FROM films_list) AND
	fa.actor_id != (SELECT actor_id FROM top_actor);
SELECT DISTINCT fa.actor_id, a.first_name + a.last_name as name -- || ' ' ||
FROM film as f
	JOIN film_actor as fa ON f.film_id=fa.film_id
	JOIN actor as a ON a.actor_id=fa.actor_id
WHERE f.film_id = fa.film_id IN (SELECT film_id FROM films_list) AND
WHERE fa.actor_id =a.actor_id != (SELECT actor_id FROM top_actor); 
  