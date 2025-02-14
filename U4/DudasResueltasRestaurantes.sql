-- Mostrar el número, el nombre de la mesa, 
-- y el número de comandas que se han hecho, de aquellas mesas
-- en las que se han hecho 2 o más comandas;

select nummesa, nombre, count(*)
	from comandas as c join mesas as m
    on m.numero = c.nummesa
    group by (numero)
    having count(*) >= 2;
    
    
-- Apartado 1.2
-- f: Mostrar los números y nombres de las mesas 
-- y los ids y fechas y no de comensales de las comandas que
-- ha habido.
select numero, nombre, id as idComanda, fecha, numComensales 
    from mesas as m join comandas as c
    on m.numero = c.nummesa
    order by numero;


-- g: Mostrar los números y nombres de las mesas 
-- y los ids y fechas y numero de comensales que
-- ha habido. Deben aparecer también las mesas 
-- para las que no ha habido comandas.
select numero, nombre, id as idComanda, fecha, numComensales 
	-- from comandas as c right join mesas as m
    from mesas as m left join comandas as c
    on m.numero = c.nummesa
    order by numero;
    
-- Invento!! Obtener los ids y nombres de las
-- mesas que no tienen comandas    
select numero, nombre, id as idComanda, fecha, numComensales 
	from comandas as c right join mesas as m
    -- from mesas as m left join comandas as c
    on m.numero = c.nummesa
    where c.id is null
    order by numero;