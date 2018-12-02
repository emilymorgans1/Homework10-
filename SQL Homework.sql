use sakila;
#1a
select first_name, last_name from actor;
#1b
select(concat( first_name," ", last_name)) as full_name from actor;
#2a
select * from actor

select actor_id, first_name, last_name from actor where first_name = 'JOE';
#2b
select actor_id, first_name, last_name from actor where last_name like '%GEN%';
#2c
select last_name, first_name from actor where last_name like '%LI%';
#2d
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");
#3a
alter table actor add column description blob after last_name
#3b
alter table actor DROP column description
#4a
select last_name from actor 

select last_name, count(last_name) as ln_count from actor group by last_name;
#4b
select last_name, count(last_name), as ln_count from actor group by last_name

UPDATE actor 
SET first_name = "HARPO"
WHERE actor_id = 172;

SELECT * FROM actor;
#4d
UPDATE actor 
SET first_name = "GROUCHO"
WHERE actor_id = 172;
#5a 

#6a 
Select * from address

SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON
staff.address_id=address.address_id;

#6b 
select * from payment

SELECT staff.first_name, staff.last_name, sum(payment.amount), payment.payment_date, staff.staff_id
FROM payment
JOIN staff ON
staff.staff_id=payment.staff_id where payment_date like "2005-08%" group by staff_id;

#6c
SELECT film.film_id,film_actor.actor_id, film.title
FROM film
inner join film_actor ON
film.film_id=film.film_id;

#6d 
select * from film 
SELECT count(film.film_id),film.title, inventory.inventory_id
FROM film
inner join inventory ON
film.film_id=inventory.film_id where title like "Hunchback Impossible" ;

#6e 
select * from payment
SELECT payment.payment_id, payment.customer_id, customer.first_name, customer.last_name, sum(payment.amount)
FROM customer
inner join payment ON
payment.customer_id=customer.customer_id group by customer_id;

#7a 
select * from film
SELECT title 
FROM film
WHERE language_id IN
(
  SELECT language_id 
  FROM language 
  WHERE name like "English"
and (title like "Q%") or (title like "K%")
);

#7b
select * from film_actor

#7c
select * from country
SELECT c.first_name, c.last_name, c.email
FROM customer AS c
INNER JOIN address AS a ON a.address_id = c.address_id
INNER JOIN city AS r ON a.city_id = r.city_id
INNER JOIN country AS z ON r.country_id = z.country_id
where country like "CANADA" 

#7d
select * from film_category
SELECT title 
FROM film
WHERE film_id IN
(
  SELECT film_id
  FROM film_category
  WHERE category_id =
	(select category_id
    from category 
    where name = "FAMILY" ));
    
#7e
SELECT c.caseref, d.devil_text, d.devil_type, a.accusedref
FROM wdb_accused AS a
INNER JOIN wdb_case AS c ON a.accusedref = c.accusedref
INNER JOIN wdb_devilappearance AS d ON d.caseref = c.caseref
WHERE d.devil_text > ' ';

SELECT f.film_id, f.title,i.inventory_id,count(r.rental_id)
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id group by film_id order by count(r.rental_id) desc

#7f
select * from PAYMENT
SELECT x.store_id, sum(p.amount)
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN staff AS s ON s.staff_id = r.staff_id
INNER JOIN store AS x ON s.store_id = x.store_id group by store_id 

#7g
select * from country
SELECT x.store_id, c.city, z.country
FROM store AS x
INNER JOIN address AS a ON a.address_id = x.address_id
INNER JOIN city AS c ON a.city_id = c.city_id
INNER JOIN country AS z ON c.country_id = z.country_id

#7h
select * from inventory
SELECT r.rental_id,r.inventory_id,sum(p.amount), c.name
FROM category AS c
INNER JOIN film_category AS f ON f.category_id= c.category_id
INNER JOIN inventory AS i ON i.film_id = f.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p ON p.rental_id = r.rental_id group by c.name ORDER BY sum(p.amount) DESC LIMIT 5;

#8a
CREATE VIEW sales_by_genre AS
SELECT r.rental_id,r.inventory_id,sum(p.amount), c.name
FROM category AS c
INNER JOIN film_category AS f ON f.category_id= c.category_id
INNER JOIN inventory AS i ON i.film_id = f.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p ON p.rental_id = r.rental_id group by c.name ORDER BY sum(p.amount) DESC LIMIT 5;

#8b 
SELECT *
FROM sales_by_genre;

#8c
drop view sales_by_genre;