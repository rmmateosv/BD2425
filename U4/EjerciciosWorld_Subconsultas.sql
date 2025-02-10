-- a
-- Vamos a hacer un select que saque la poblacion de cada continente
select(select sum(population) from country
	where continent='europe') Poblacion_Europa,
 (select sum(population) from country
	where continent='asia')Poblacion_Asia,
 (select sum(population) from country
	where continent='africa')Poblacion_Africa,
 (select sum(population) from country
		where continent='north america' or continent='south america')Poblacion_America,
 (select sum(population) from country
	where continent='oceania') Poblacion_Oceania;
-- b
    -- paso 1:¿cuantas lenguas oficiales tiene España?
    select count(*) as oficiales
    from countrylanguage
    where countrycode='esp' and IsOfficial='t';
 -- paso2: ¿cuantas lenguas no oficiales tiene españa.
     select count(*) as no_oficiales
    from countrylanguage
    where countrycode='esp' and IsOfficial='f';
    
    -- paso 3: select principal que muestra las dos cosas
    
select (select count(*) from countrylanguage
			where countrycode='esp' and IsOfficial='t') as Oficiales,  
		(select count(*) from countrylanguage
			where countrycode='esp' and IsOfficial='f') as No_Oficiales;
            
-- C 
-- Paso 1: averiguar la poblacion mundial

select sum(population) from country;

-- Paso 2: Mostrar la población de cada continente

select continent, sum(population) from country
	group by continent;
    
-- Paso 3: añadir al paso 2 una nueva columna que calcule 
-- el % que pide el enunciado

select continent, sum(population), sum(population)/(select sum(population)
													from country)*100 as porcentage 
	from country
	group by continent;
    
-- d) 
-- Metemos un registro de Unesco ya que en la base de datos actual, no salía
-- ningun pais en el 2019 que tuviese por PRIMERA VEZ declarado un lugar 
-- patrimonio de la humanidad

-- se inserta en 2019 en UNESCO en countrycode
-- BVT (Antartida), un lugar patrimonio de la humanidad que es su primera
-- vez

-- paso 1: Saber el ultimo año donde se han reconocido lugares Patrim Hum

select max(year)
	from unesco;

-- Paso 2: Sacar el primer año donde se declara un patrimonio de la humanidad
-- en un pais

select min(year), countryCode
	from unesco
    group by countrycode;

-- Paso 3: Mostrar los registros del paso 2 cuyo año sea el mismo que el del
-- 			paso1

select min(year), co.name
	from unesco join country co
				on countrycode = code
    group by countrycode
    having min(year) = (select max(year)
							from unesco);
-- e)
-- Paso 1: Saber el año mas reciente en el que se ha independizado un pais
select max(Indepyear) from country 
	where continent = 'Europe';
    
-- Paso 2: Mostrar los paises cuyo año de idependencia sea
-- igual al resultado de la consulta del paso 1

select name from country 
	where continent = 'Europe' 
		and Indepyear = (select max(Indepyear) 
							from country 
							where continent = 'Europe');
-- f
-- Paso 1 
-- Averiguar la población más baja de un país
select min(population)
	from country;
    
select name 
	from country
    where population = (select min(population)
	from country);
    
-- g 
-- Paso 1: Calcular cual es la media de la población 
-- de los paises de europa
select avg(population) from country 
	 where continent = 'Europe';
     
-- Paso 2: que paises europeos tienen mas poblacion 
-- del valor devuelto en el paso 1
select name from country 
	where continent = 'Europe'
    and population > (select avg(population) from country 
	 where continent = 'Europe');
     
-- h
-- Paso 1: Calcular la población media de un país concreto
-- se calcula con la población de las ciudades
select avg(population)
	from city
	where CountryCode = 'ESP';
-- Paso 2: Mostrar nombre y población de ciudades europeas
-- cuya población supere el valor obtenido en el paso 1 
-- poninendo como código de país el código de país de esa ciudad
select ci.name, ci.population 
	from city as ci join country on CountryCode = Code
	where continent = 'Europe' and 
		ci.population > (select avg(population)
							from city
							where CountryCode = ci.CountryCode);
-- i
-- forma 1 con mayor que todos
-- Paso 1:Averiguar la poblacion de los paises africanos

select distinct population
	from country
    where continent = 'Africa';
    
-- Paso 2:Mostrar el nombre de los paises europeos
-- cuya poblacion sea mayor que todos los valores obtenidos
-- en la consulta 1

select name
	from country
    where continent = 'Europe'
    and population > ALL(
    select distinct population
		from country
		where continent = 'Africa');
        
-- forma 2 mayor que todos equivale a decir mayor que el valor maximo

select name
	from country
    where continent = 'Europe'
    and population > (
    select max(population)
		from country
		where continent = 'Africa');

-- j
-- Forma 1
-- Paso 1: Averiguar esperanza de vida de los países europeos
select distinct LifeExpectancy
	from country
    where continent = 'Europe';
-- Paso 2: Mostrar el nombre de los países africanos cuya esperanza de vida
-- sea mayor que la mde alguno de los obtenidos en el paso anterior
select name
	from country
    where continent = 'Africa'
    and LifeExpectancy > ANY (select distinct LifeExpectancy
	from country
    where continent = 'Europe');
-- Forma 2 mayor que ANY es lo mismo que decir mayor que el minimo
select name
	from country
    where continent = 'Africa'
    and LifeExpectancy > (select min(LifeExpectancy)
	from country
    where continent = 'Europe');
    
-- k)
-- Parte 1: Saber si un país tiene más de 10 lugares patrimonio de la humanidad
select count(*)
	from unesco
	where countryCode = 'BVT'
	having count(*) > 10;

-- Parte 2: Sacar los nombres de los paises
select name, code
	from country
    where exists (select count(*)
					from unesco
                    where countryCode = code
					having count(*) > 10);

-- L
-- Parte 1: Saber si un país tiene más de 10 
-- lugares patrimonio de la humanidad
select count(*)
	from unesco
	where countryCode = 'ESP'
	having count(*) > 10;
-- Paso 2
-- Seleccionar los paises para los que la consulta 
-- de la parte 1 no devuelva nada.
select name, code
	from country
    where not exists (select count(*)
					from unesco
                    where countryCode = code
					having count(*) > 10);
-- m
-- Paso 1
-- Mostrar las ciudades de más de 1M
-- de habitantes de un país concreto
select * from city
	where CountryCode = 'BVT'
    and Population > 1000000;
-- Paso 2
-- Mostrar los países para los que
-- la consulta del paso 1 devuelva algo
select name, code from country
	where exists (select * from city
				where CountryCode = code
				and Population > 1000000);
                
-- N

-- Paso 1 Obtener el numero de habitantes 
-- de la ciudad menos poblada
-- para cada pais

select min(population)as poblacion ,countrycode
	from city
		group by CountryCode;

-- Paso 2
-- Hacer un join de la tabla paises 
-- con la subconsulta del paso 1
-- la clusula on se haria sobre el codigo del pais
-- se mostraria el nombre el continente y el min poblacion

select name, continent,sc.poblacion
	from country
		join (select min(population) poblacion ,countrycode
				from city
					group by CountryCode) as sc
		on code = sc.countrycode;

-- o 
-- Paso 1 
-- mostrar para cada pais el ultimo año en el que se 
-- le ha reconocido un lugar patrimonio de la humanidad
select countrycode, max(Year) as anio
from unesco
Group by countryCode; 
-- paso 2 hacer un outer join de Country con la tabla obtenida en el paso 1
 select  name , sc.anio
 from country left join (select countrycode, max(Year) as anio
									from unesco
									Group by countryCode) as sc
				on code = sc.countrycode
order by sc.anio desc,name ;


    

    
                            










