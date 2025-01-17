-- a
select name as 'Nombre Pais', population Población
	from country
    where continent = 'Europe' and 
          population < 1000000
    order by population;
-- b
select *   
	from country
    where continent = 'asia' and
		governmentForm = 'Monarchy'
	order by name;
-- c
select *   
	from country
    where name != localname;
-- d (Consideremos como grande la superficie)
select *   
	from country
    order by SurfaceArea desc
    limit 3;
-- d (Consideremos como grande la población)
select *   
	from country
    order by population desc
    limit 3;
-- e
select *
	from country
    where continent = 'Europe'
    order by surfacearea desc
    limit 3;
    
-- f
select * 
	from country
    where LifeExpectancy is null and
    capital is null and
    IndepYear is null;
-- g  
select * 
	from country
    where LifeExpectancy is null or
    capital is null or
    IndepYear is null;  
-- h
select name, continent, governmentform
	from country
    where HeadOfState = '' or HeadOfState is null ;
-- i
select name as 'Nombre'
	from unesco
    where year is null
    order by name;
-- j
select name as 'Nombre', year
	from unesco
    where year between 2000 and 2001
    order by year desc, Nombre;   
select name as 'Nombre', year
	from unesco
    where year >= 2000 and year <=2001
    order by year desc, Nombre;  
select name as 'Nombre', year
	from unesco
    where year = 2000 or year =2001
    order by year desc, Nombre;   
select name as 'Nombre', year
	from unesco
    where year in (2000,2001)
    order by year desc, Nombre;
-- k 
select name as 'Nombre', year
	from unesco
	where year between 2000 and 2005
	order by year desc, Nombre;     
-- k (Sin duplicados)
select distinct name as 'Nombre', year
	from unesco
	where year between 2000 and 2005
	order by year desc, Nombre; 
-- l
select distinct name
	from unesco
	where name like '%parque nacional%'; 
-- m
select name, lifeexpectancy
	from country
    order by LifeExpectancy desc
    limit 1;
-- n
select distinct countryCode
	from unesco
    order by countryCode
    limit 5000;
    