use world;
-- a
select count(*) NumPaises1, count(code) numPaises2 
	from country;
-- ampliación  
-- count(*): Cuenta registros
-- count(campo): Cuenta registros para los que el campo no es nulo
-- count(distinct campo):  Cuenta registros para los que el campo no se repite
select count(*) NumPaises1, count(code) numPaises2, 
		count(continent) numPaises3, 
        count(distinct continent) numContinentes,
        count(indepYear) 
	from country;
-- b
select count(IndepYear) as NumPaisesConIndependencia,
		count(distinct indepYear) as NumAñosIndependencia
		from country;
-- c
select count(distinct indepYear) as NumAñosIndependencia
		from country;
-- d
select count(*) as NumLugares, count(distinct countrycode) as numPaisesConPatriminioh        
	from unesco;

-- e
select min(population), max(Population), avg(population),
	sum(population)
		from country;
-- f
select count(*) as NumPaisesEuropeos
	from country
    where continent = 'Europe';
-- g
select max(population) - min(population)
	from country;
-- h
select continent, count(*)
	from country
    group by continent
    order by count(*) desc;
-- Solución dos con alias    
select continent, count(*) as NumPaises
	from country
    group by continent
    order by NumPaises desc;    
-- i
select	IndepYear, count(*) as numPaises
	from country
    where IndepYear is not null
    group by IndepYear
    order by IndepYear;
-- j
select co.name nombre, count(c.id) numCiudades, count(*) numCiudades
	from country co join city c on co.code = c.countrycode
    where continent = 'Europe'
    group by co.code -- Cuidado si ponemos un campos de pais que se puede repetir
    order by numciudades desc;
-- k
select co.name nombre, co.population, count(c.id) numCiudades, 
	min(c.population) PoblacionMínima, max(c.population) PoblacionMáxima, 
    avg(c.population) PoblacionMediaPaís, sum(c.population) PoblacionPaís 
	from country co join city c on co.code = c.countrycode
    where continent = 'Europe'
    group by co.code
    order by numciudades desc;
-- L
select c.name, count(*)
	from country c join unesco u on c.code=u.countryCode
    where continent = 'Europe'
    group by c.code;    
-- M
select c.name, count(id) -- Ahora es count id porque sí hay nulos en 
-- los países que no tienen ningún lugar
	from country c left join unesco u on c.code=u.countryCode
    where continent = 'Europe'
    group by c.code;     
-- N
select continent, avg(lifeExpectancy) as EsperanzaMediaDeVida
	from country
    group by Continent
    having EsperanzaMediaDeVida>70;
-- o
select co.name nombre, count(c.id) numCiudades 
	from country co join city c on co.code = c.countrycode
    group by co.code
    having numCiudades <5 and avg(c.Population) < 1000;    
-- p
select countrycode, count(*) numLen
	from countrylanguage
    group by CountryCode
	order by numLen;
-- q
select name, count(*) numLen
	from countrylanguage join country on CountryCode = code
    group by CountryCode
	order by numLen;
-- r    
select name, count(*) numLen
	from countrylanguage join country on CountryCode = code
    group by CountryCode
    having numlen = 1
	order by numLen;
-- s
    