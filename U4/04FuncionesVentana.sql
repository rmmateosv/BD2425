use world;

-- Mostrar el nombre de un pais, su población,
-- la población total de su continente
-- la población total del mundo
-- el % que supone la población del país respecto a la del continente
-- el % que supone la población del país respecto a la mundial
select continent, name, population,
-- Over indica sobre qué registros se hace la media. 
-- En este caso se hace sobre todos los registros = over()
	sum(population) over() as MediaMundial,
    population / sum(population) over() * 100 as '% Mundo',
-- Over se hace agrupando por continente
	sum(population) over(partition by continent) as MediaContinente,
    population / sum(population) over(partition by continent) * 100 as '% Continente'
	from country;
-- Mostrar el nombre de un país, el nº de fila que ocupa
-- en la tabla country
-- y el nº de fila en la tabla country según el continente.
select name,
	row_number() over() as 'NºFilaMundial',
    row_number() over(partition by continent) as 'NºFilaContinente'
    from country
    order by Continent, name;
    
-- Mostrar el nombre de los países y un ranking por población
-- Hacerlo con rank() y dense_rank()
-- Con rank() se pierden nº del ranking en los empates
select name, population,
	rank() over(order by population desc) as ranking,
    dense_rank() over(order by population desc) as ranking2
    from country;
    
-- Mostrar el nombre de los países y asignarles 
-- un grupo sabiendo que el nº  grupos es 5.
select name,
	ntile(5) over() as 'NºGrupo'
    from country;
-- Mostrar el nombre de un país, su población,
-- la población del país anterior y la del siguiente
select name, population,
	lag(population) over(order by population desc) as anterior,
    lead(population) over(order by population desc) as posterior
	from country;
    
    
    