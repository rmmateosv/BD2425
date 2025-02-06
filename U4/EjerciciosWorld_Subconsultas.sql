-- 1
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
    -- 2
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











