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