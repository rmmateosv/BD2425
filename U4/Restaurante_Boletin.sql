use comandas;

-- 1 Consultas de selección
	-- 1.1 Consultas Básicas
		-- a. Mostrar todos los datos de todas las mesas.
select *
	from mesas;
    
		-- b. Mostrar el nombre y el precio de todos platos.
select nombre, precio
	from platos;
        
		-- c. Mostrar los número y nombres de las mesas que tienen alguna observación.
select numero, nombre
	from mesas
    where observaciones is not null;
        
		-- d. Mostrar los nombres y el precio de los platos cuyo precio está comprendido entre 10 y
		-- 15 euros.
select nombre, precio 
	from platos 
    where precio between 10 and 15;
		-- e. Mostrar sin duplicados las alergias que hay en los platos.
select distinct alergias
	from platos
    where alergias is not null;
		-- f. Mostrar el nombre y el precio los tres platos más caros.
select nombre, precio
	from platos
    order by precio desc
	limit 3;
		-- g. Mostrar el nombre de los platos que contengan el texto de.
select nombre
	from platos 
    where nombre like '%de%';
		-- h. Mostrar el número, el nombre, el número de personas de las mesas que no tengan
		-- ninguna observación. Los datos deben salir ordenados de menor a mayor número de
		-- comensales.
select numero, nombre, numPersonas
	from mesas
    where observaciones is not null
    order by numPersonas;

-- 1.2 Consultas con Join
	-- a. Mostrar todos los datos de la comanda 1. Debe aparecer el id de la comanda, la fecha,
		-- el número de mesa, el número de comensales, si se ha pagado, el id del plato, la
		-- cantidad y el precio unitario.

select numero, numComensales, pagado, idPlato, cantidad, precioUnidad 
	 from detallecomanda dc join comandas on dc.idcomanda = id
						 join mesas on nummesa = numero
                         where id=1;

	-- b. Mostrar los id de las comandas en las que se ha pedido el plato 1.
select idcomanda 
		from detallecomanda join platos pla on pla.id = idPlato
		where idplato = 1;

	-- c. Mostrar los id de las comandas y las fechas en las que se ha pedido el plato 1.
select dc.idComanda, co.fecha 
	from comandas co join detallecomanda dc on co.id= dc.idcomanda
	where dc.idplato=1;

	-- d. Mostrar los platos que se han pedido en la comanda 1. Debe aparecer el nombre del
		-- plato, la cantidad y el precio unitario.

select pla.nombre, dc.cantidad, dc.precioUnidad
	from platos pla join detallecomanda dc on pla.id = dc.idplato
    where idComanda=1;
    

	-- e. Mostrar sin duplicados el número y nombre de las mesas donde se han pedido los
		-- platos del 1 al 5. Los datos deben aparecer ordenados por número de mesa.
        
select distinct me.numero, me.nombre
	from mesas me join comandas co on me.numero = co.nummesa
				join detallecomanda dc on co.id = dc.idComanda
	where dc.idplato between 1 and 5;
	-- f. Mostrar los números y nombres de las mesas y los ids y fechas y no de comensales que
		-- ha habido.
    
    select me.numero, me.nombre, co.id, co.fecha, co.numcomensales
		from mesas me join comandas co on me.numero = co.nummesa;
        
	-- g. Mostrar los números y nombres de las mesas y los ids y fechas y no de comensales que
		-- ha habido. Deben aparecer también las mesas para las que no ha habido comandas.
        
        select me.numero, me.nombre, co.id, co.fecha, co.numcomensales
		from mesas me left join comandas co on me.numero = co.nummesa;

-- 1.3 Consultas con funciones de totales/agregación
	-- a. Mostrar el número de mesas.
select count(*)
	from mesas;
    
	-- b. Mostrar cuántas mesas hay por número de personas.
select numPersonas, count(*) as numMesas
	from mesas
group by numPersonas;
	-- c. Mostrar para cada tipo de alergias, cuántos platos hay, siempre que haya más de 1
		-- plato para ese tipo de alergias.

select count(*) as CountPlatos
	from platos 
    group by alergias 
    having CountPlatos > 1;

	-- d. Mostrar para cada comanda (id,fecha, numero de mesa) cuántos platos se han servido.
    select co.id, co.fecha, co.nummesa, count(*) as NumPlatos
		from comandas co join detallecomanda dc on co.id = dc.idcomanda
        group by co.id;
        
	-- e. Mostrar para cada comanda (id,fecha, numero de mesa) cuántos platos se han servido,
		-- el precio del plato más barato, el precio del plato más caro, el precio medio de los
		-- platos y el importe total de todos los platos.
     select co.id, co.fecha, co.nummesa, count(*) as NumPlatos, min(precio), max(precio), avg(precio), sum(precio) preciototal
		from comandas co join detallecomanda dc on co.id = dc.idcomanda
						join platos pla on dc.idplato = pla.id
        group by co.id;
    
    
	-- f. Mostrar para cada plato (nombre), cuántas veces se ha servido y lo que se ha
		-- recaudado con él.

select pla.nombre, count(numMesa), sum(precio) 
	from platos pla join detallecomanda dc on dc.Idplato = pla.id
					join comandas co on dc.idcomanda = co.id
	group by nombre;

	-- g. Mostrar los platos (nombre) que se han servido más de 3 veces.
    
    select pla.nombre, count(idplato)
		from platos pla join detallecomanda dc on pla.id = dc.idplato
        group by idplato
        having count(idplato) >3;