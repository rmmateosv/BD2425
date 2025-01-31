use world;

-- Mostrar los nombres de las ciudades y 
-- los nombres de los países.
select name
	from city
UNION
select name from country;    

-- Mostrar los nombres de las ciudades y 
-- los nombres de los países poniendo
-- El prefijo C- si es ciudad y P- Si es país.
select concat('C-',name)
	from city
UNION
select concat('P-',name) from country;

-- Mostrar nombre de ciudades que coincia con el nombre
-- de un país
select name
	from city
INTERSECT 
select name from country;   

-- Mostrar los códigos de los países
-- que no tienen lugares patrimonio de la humanidad
-- (Se puede hacer con outer join y es más EFICIENTE)
select code from country
except
select countrycode from unesco;

-- Outer join
select code
	from country left join unesco
		on code=countryCode
	where countrycode is null;