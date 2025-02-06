use world;

-- Mostrar para cada país el nombre, la esperanza de vida
-- la diferencia con respecto a la esperanza de vida más
-- alta del mundo

-- subconsulta que calcula la esperanza de vida más alta
-- Me debe devolver 1 solo valor
select name, lifeExpectancy, *¿más alta?* - LifeExpectancy as diferencia
	from country;
-- Paso 1
-- Suconsulta que calcula la más alta    
select max(lifeExpectancy)
	from country;
-- Paso 2
-- Incluímos la subconsulta en la consulta en el lugar correspondiente
select name, lifeExpectancy, 
	(select max(lifeExpectancy) from country) - LifeExpectancy 
		as diferencia
	from country;
    
-- Mostrar el PNB y el nombre 
-- de cada país y el % que supone respecto al de USA
select name, gnp, gnp/¿gnpUSA?*100
	from country;
-- Paso 1:Calcular el gnp de USA
-- ¿Cuántos valores debe devolver la subconsulta ?
-- Solamente 1
-- El where hay que hacer por PK (o alternativa) para asegurar
-- que devuelve 1 valor
select gnp
	from country where code = 'USA';
-- Paso 2: Integrar la subconsulta en el lugar adecuado
select name, gnp, gnp/
		(select gnp
		from country where code = 'USA')*100
	from country;    

-- Mostrar el nombre y la esperanza de vida
-- de los países que superan la esperanza
-- de vida media
-- ordenados por esperanza de vida media
-- de forma que salgan primero
-- los paises más longevos
select name, lifeexpectancy
	from country
    where LifeExpectancy > ¿Esperanza de vida media?
    order by lifeExpectancy desc;
-- Paso 1: ¿Esperanza de vida media?
-- La subconsulta debe devolver un solo valor
-- ya que estoy comparando dos valores con el operador >    
select avg(lifeexpectancy)
	from country;
-- Paso 2: Integrar
select name, lifeexpectancy
	from country
	where LifeExpectancy > (select avg(lifeexpectancy)
								from country)
    order by lifeExpectancy desc;
    
-- Mostrar el país, el nombre de ciudad
-- y la población de las ciudades europeas
-- cuya población supera la población 
-- media de su país.    

select p.name, c.name, c.popultion
	from country as p join city as c
		on p.code = c.CountryCode
	where p.Continent = 'Europe' and
		c.Population > ¿poblacion media del país?;
-- Paso 1
-- Obtener la población media de un país
-- El código del páis lo ponemos fijo
-- pero cuando integremos la subconsulta
-- en la consulta, va a sustituirse por 
-- el código del país de la ciudad que está
-- tratando el select principal
select avg(population)
	from city
    where CountryCode = 'FRA';
    
-- Paso2:Integrar consulta y subconsulta
select p.name, c.name, c.population
	from country as p join city as c
		on p.code = c.CountryCode
	where p.Continent = 'Europe' and
		c.Population > (select avg(population)
							from city
							where CountryCode = p.code);  
-- Solución 2                            
select p.name, c.name, c.population
	from country as p join city as c
		on p.code = c.CountryCode
	where p.Continent = 'Europe' and
		c.Population > (select avg(population)
							from city as c2
							where c2.CountryCode= c.CountryCode);                              
-- Idem, mostrando la media
select p.name, c.name, c.population,  (select avg(population)
							from city
							where CountryCode = p.code)
	from country as p join city as c
		on p.code = c.CountryCode
	where p.Continent = 'Europe' and
		c.Population > (select avg(population)
							from city
							where CountryCode = p.code);     
-- Páises cuya esperanza de vida
-- es mayor que las de todas las del
-- continente africano
select name, lifeExpectancy
	from country
    where LifeExpectancy > ALL ¿Esperanzas de vida de paises Africanos?;
-- Paso 1: ¿Esperanzas de vida de paises Africanos?    
select lifeExpectancy
	from country
    where continent = 'Africa'  and LifeExpectancy is not null;
-- Paso 2
-- Tenemos que quitar los nulos de las subconsulta
-- porque si no, ALL no funciona
select name, lifeExpectancy
	from country
    where LifeExpectancy > ALL (select lifeExpectancy
									from country
									where continent = 'Africa' and
										LifeExpectancy is not null);
-- Solución 2: Con > que el máximo
 select name, lifeExpectancy                                     
	from country
    where LifeExpectancy > (select max(lifeExpectancy)
									from country
									where continent = 'Africa');

-- Mostrar países cuyo GNP sea
-- mayor que el de algún país norte americano
-- Solución 1: > ANY
-- Paso 1 ¿GNP de países norte americanos?
select gnp
	from country 
	where continent='North America';
-- Paso 2: Integrar consultas
select name, gnp
	from country
    where gnp > ANY (select gnp 
					from country 
                    where continent='North America');
-- Solución 2: > min
-- Paso 1
select min(gnp) 
	from country 
	where continent='North America';
    
select name, gnp
	from country
    where gnp > (select min(gnp) 
					from country 
                    where continent='North America');
                    
-- Mostrar los países para los que solamente
-- hay 1 ciudad (NO USAR JOIN)
-- ¿Cómo se haría con JOIN?                    
select c.name
	from country c join city ci
		on c.code =ci.CountryCode
	group by c.Code
    having count(*) = 1;
-- Con subconsultas
select name
	from country
    where ¿exista solamente una ciudad para ese país?;
-- Paso 1: Saber si para un país concreto, hay
-- solamente una ciudad. Mostrar datos de la ciudad
select CountryCode
	from city
    where countrycode = 'ESP'
    group by countrycode
    having count(*) = 1;
-- PAso2: Integrar 
select name
	from country as p
    where EXISTS (select CountryCode
					from city
					where countrycode = p.code
					group by countrycode
					having count(*) = 1);       
                    
-- Mostrar cúanta ciudaes tiene el 
-- país con más ciudades. NO USAR LIMIT
-- Habría que calcular el nº de ciudades
-- de cada país. Después habría que 
-- calcular el máximo del campo nº de ciudades
-- del resultado anterior.
-- Paso 1: Nº de ciudades por país
select countrycode, count(*) as numCiudades
	from city
    group by countrycode;
-- Paso 2: Calcuar el máximo de la tabla obtenida
-- por la subconsulta
select max(sc.numCiudades)
	from (select countrycode, count(*) as numCiudades
				from city
				group by countrycode) as sc;


-- Mostrar el nombre y el nº de ciudades
-- del/de los países con el nº de ciudades más alto
-- NO USAR LIMIT
select p.name, count(*) as numCiudades
	from country p join city c
		on p.code = c.countrycode
	group by p.code
    having numCiudades = (select max(sc.numCiudades)
								from (select countrycode, 
											count(*) as numCiudades
											from city
											group by countrycode) as sc);







                    