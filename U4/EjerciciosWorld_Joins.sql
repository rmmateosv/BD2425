use world;
-- a
select c.name, p.name
	from city as c inner join country as p
		on c.countrycode = p.code;
select c.name, p.name
	from city  c inner join country as p
		on countrycode = code;
        
-- b
select c.name, p.name
	from city as c inner join country as p
		on code = countrycode
	where continent = 'Europe';
-- c
select c.name, p.name, c.population
	from city as c inner join country as p
		on code = countrycode
	where continent = 'Europe' and
		c.population>1000000
	order by c.population desc;    
-- d
-- Sin join
select language
	from countrylanguage
    where countrycode = 'ESP';
-- Con join, utilzando el nombre del país en vez de el código
select language
	from countrylanguage join country 
		on countrycode = code
	where name = 'Spain';
-- e
-- Join de 3 tablas (menos eficiente)
select language, isOfficial, percentage
	from city as c join country on c.countrycode = code
		join countrylanguage as cl on code = cl.countrycode
	where c.name = 'Paris'
    order by Percentage;
-- Join de 2 tablas (Mejor opción en esta consulta)  
select language, isOfficial, percentage
	from city as c join countrylanguage as cl 
		on c.CountryCode = cl.countrycode
	where c.name = 'Paris'
    order by Percentage;  
-- f
select name, language, percentage
	from city as c join countrylanguage as cl 
		on c.CountryCode = cl.countrycode
    order by population desc, percentage desc
    limit 1;      
-- g
select unesco.name, unesco.year, country.name
	from country join unesco on country.code=unesco.countryCode
    order by unesco.year, country.name;
-- h
select unesco.name, unesco.year, country.name
	from country join unesco on country.code=unesco.countryCode
    where country.continent = 'Europe'
    order by unesco.year, country.name;
-- i
select country.name, unesco.name, unesco.year
	from country left join unesco on country.code=unesco.countryCode
    order by unesco.year, country.name
    limit 10000;
-- j    
select country.name, country.capital, city.id, city.name
	from country join city 
		on country.capital = city.id;

 -- k   
 select country.name, country.capital, city.id, city.name
	from country left join city 
		on country.capital = city.id;
-- l : Páises sin capital
select country.name, country.capital, city.id, city.name
	from country left join city 
		on country.capital = city.id
	where city.id is null;
-- Mejor opción     
select country.name
	from country 
	where country.capital is null;
    
-- O: Mostrar las ciudades que no son capitales de país
select *
	from city left join country
		on city.id = country.capital
	where country.code is null;
    
    
    
    