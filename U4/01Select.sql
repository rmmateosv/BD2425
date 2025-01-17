-- SELECT y FROM
-- Mostrar el nombre y la población de los países
select name, population
	from country;
    
-- mostrar todos los datos de los países
select *
	from country;
    
-- mostrar el nombre y la población de los países
-- pero renombra las columnas 
-- para que salgan en castellano    
select name as Nombre, population as 'Población Ciudad'
	from country;
    
select name Nombre, population 'Población Ciudad'
	from country;   

-- Mostrar los continentes de los países
select continent
	from country;
-- Ídem, pero sin duplicados
select distinct continent
	from country;
-- Mostrar la fecha de hoy y 
-- el resultado de la operación 3421*8    
select curdate() Hoy, 3421*8 Operacion;

-- Mostrar los nombres de los lugares
-- patrimonio de la humanidad españoles, el país
-- al que pertenecen, el año de reconocimiento
-- y cuánto años han pasado desde que se han
-- reconocido
select name, countryCode, year, 2025-year NumAños
	from unesco
    where countrycode = 'ESP';
    
-- Mostrar todos los datos de las 
-- ciudades españolas
select *
	from city
    where CountryCode = 'ESP';
-- Mostrar todos los datos de las 
-- ciudades españolas o portuguesas
select *
	from city
    where CountryCode = 'ESP' or 
		  CountryCode = 'PRT' ;    
-- Mostrar los datos de la ciudades
-- españolas del distrito Andalusia
          select *
	from city
    where CountryCode = 'ESP';
-- Mostrar todos los datos de las 
-- ciudades españolas o portuguesas
select *
	from city
    where CountryCode = 'ESP' and
    district  = 'Andalusia';  
-- Mostrar el nombre de las ciudades españolas
-- que tienen entre 100000 y 500000 habitantes
select name
	from city
    where Population between 100000 and 500000
    and CountryCode ='ESP';
-- Mostrar el nombre de las ciudades
-- españolas que empiezan por a
select name
	from city
    where CountryCode ='ESP' and 
    name like 'A%';  
-- Mostrar el nombre de las ciudades
-- españolas que no empiezan por vocal
select name
	from city
    where CountryCode ='ESP' and 
	name not like 'A%' and name not like 'E%' and
     name not like 'I%'and name not like 'O%' and 
     name not like 'U%' ; 
-- Mostrar los nombres de las ciudades españolas
-- que contenga la palabra de
select name
	from city
    where CountryCode ='ESP' and 
    (name like '% de %' or name like 'de %'
    or name like '% de');
-- Mostrar los nombres de las ciudades españolas
-- que contenga la sílaba de 
select name
	from city
    where CountryCode ='ESP' and 
    name like '%de%';  

-- Mostrar el nombre y el pais de 
-- las ciudades que acaben en de 
-- de España, Brasil, Francia, Italia u Portugal
select name, CountryCode
	from city
    where CountryCode 
		in ('ESP','BRA','FRA','ITA','PRT') and 
    name like '%de';      
-- Mostrar el nombre y el pais de las ciudades
-- que no sean de ningún país usado en la 
-- consulta anterior
select name, CountryCode
	from city
    where CountryCode 
		not in ('ESP','BRA','FRA','ITA','PRT');  


-- Mostrar el país, el nombre y la población de 
-- ciudades con más de 1000000 de habitantes.
-- Los datos deben salir ordenados por páis
-- y dentro del mismo país por habitantes
-- de forma que salgan primero la ciudades
-- con más habitantes
select countryCode Pais, name, population    
	from city
    where Population > 1000000
    order by Pais, population desc; 
-- Mostrar los lugares patrimonio de la humanidad
-- españoles. Debe aparecer el nombre y 
-- el año en el que se han declarado patrimonio
-- de la humanidad. Además, el listado debe
-- estar ordenado por año de forma que salgan
-- primero lo más recientes. En caso de empate
-- el listado se ordenará alfabéticamente por nombre
select name, year
	from unesco
    where countryCode = 'ESP'
    order by year desc, name;

-- Mostrar el nombre de la ciudad USA con
-- Más habitantes.    
select name
	from city
    where CountryCode = 'USA'
    order by Population desc
    limit 1;
-- Mostrar la tercera ciudad más poblada del mundo
 select name
	from city
    order by Population desc
    limit 2,1;   