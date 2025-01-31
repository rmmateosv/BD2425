use bd_empresa;
-- 1
select idFab, idproducto, descripcion, precio, 
	precio * 1.21 as PrecioConIva, precio * 1.21 PrecioConIva2, 
    precio * 1.21 as 'Precio con Iva'
    from productos;
    
-- 2
select numpedido, fabricante, producto,
		cantidad, importe/cantidad as precioUnitario, importe
        from pedidos;
-- 3        
select nombre, datediff(curdate(),contrato) as numDias, 
     (year(curdate())- edad) as 'Año Nacimiento'
	from empleados;
-- 4
select * 
	from oficinas
    order by region, ciudad, oficina desc;
-- 5
select *
	from pedidos
    order by fechaPedido;
    
-- 6
select *
	from pedidos
    order by importe desc
    limit 4;
    
-- 7
select numpedido, fabricante, producto,
		cantidad, importe/cantidad as precioUnitario, importe
        from pedidos
        order by precioUnitario
        limit 5;    

-- 8
select *
	from pedidos
    where month(FechaPedido) = 3;
select *
	from pedidos
    where FechaPedido like '%-03-%';
select *
	from pedidos
    where FechaPedido like '____-03-__';    
-- 9
select numEmp
	from empleados
    where Oficina is not null;

-- 10
select oficina
	from oficinas
    where dir is null;
    
-- 11
select *
	from oficinas
    where region = 'este' or region = 'norte'
    order by region desc;
select *
	from oficinas
    where region in ('este','norte')
    order by region desc;
-- 12
select *
	from empleados
    where nombre like '%Julia%';
-- 13
select *
	from productos
    where IdProducto like '%x';

-- 14
-- Con empleados
select o.oficina, o.ciudad,
	e.numemp NúmeroEmpleado, e.nombre NombreEmpleado
    from oficinas o inner join empleados e
		on o.oficina = e.oficina
	where o.region = 'este';
-- Sin empleados   
select o.oficina, o.ciudad,
	e.numemp NúmeroEmpleado, e.nombre NombreEmpleado
    from oficinas o left outer join empleados e
		on o.oficina = e.oficina
	where o.region = 'este' and e.numEmp is null; 

-- 15
select p.numpedido, p.importe, c.nombre, c.limitecredito
	from pedidos as p join clientes as c
		on p.cliente = c.numclie;
-- 16
select e.*, o.ciudad, o.region 
		from empleados as e join oficinas as o
			on e.oficina = o.oficina;
            
select e.*, o.ciudad, o.region 
		from empleados as e left join oficinas as o
			on e.oficina = o.oficina;            
-- 17
select o.*, e.nombre
	from oficinas o join empleados e
		on o.dir = e.numEmp
	where objetivo > 3600;   
        
select o.*, e.nombre
	from oficinas o left join empleados e
		on o.dir = e.numEmp
	where objetivo > 3600;

select o.oficina, o.ciudad, e.nombre
	from empleados e right join oficinas o
		on e.numEmp = o.dir
	where objetivo > 3600;   

-- 18
select pedidos.*, empleados.nombre Empleado, clientes.nombre Cliente
	from pedidos join empleados 
		on pedidos.Representante = empleados.NumEmp
        join clientes on pedidos.cliente = clientes.NumClie
	where pedidos.importe > 150;
-- 19
-- Si el empleado hubiera creado dos o más pedidos
-- el día en que fue contratado, saldría más de una vez
select   e.*
	from empleados e join pedidos p
		on e.numemp = p.Representante
	where p.FechaPedido = e.contrato;
-- Elimina registros duplicados en caso de que los haya
select distinct e.*
	from empleados e join pedidos p
		on e.numemp = p.Representante
	where p.FechaPedido = e.contrato;    

-- 20
select e.*, j.numemp as numJefe,
	j.nombre as nombreJefe, j.cuota as cuotaJefe
    from empleados e join empleados j
		on e.jefe = j.numemp
	where e.cuota > j.cuota;
-- 21
-- No deben salir duplicados
select distinct e.NumEmp
	from empleados e join pedidos p
		on e.numemp = p.Representante
	where p.importe > 60 or e.cuota < 60;        
    
-- 22
select avg(cuota) as CuotaMedia, avg(ventas) as VentasMedias
	from empleados;
-- 23
select avg(importe) as ImporteMedio,
	sum(importe) as ImporteTotal,
    avg(importe/cantidad) as PrecioMedio
	from pedidos;
-- 24
select avg(precio) as PrecioMedio
	from productos
	where idfab = 'aci';
-- 25    
select sum(importe) as ImporteTotal
	from pedidos as p join empleados as e
		on p.representante = e.numemp
	where e.nombre = 'Vicente Pantalla';
-- 26
select min(fechapedido)
	from pedidos;
-- 27
select count(*) as NumPedidos
	from pedidos
    where importe >150;
-- 28
select oficina, count(*) as CantidaEmpleados
	from empleados
    group by oficina;
-- 29
select e.numemp, e.nombre, sum(p.importe),
       p.cliente
	from empleados as e join
		pedidos as p on p.Representante = e.NumEmp
	group by e.NumEmp, p.cliente;
-- 30
select representante, avg(importe)
	from pedidos
    group by representante
    having sum(importe)>180;
-- 31
select descripcion, precio, existencias, sum(cantidad) as cantidadTotal
	from productos join pedidos
		on IdProducto=producto and idfab=fabricante
	group by idfab,IdProducto
    having cantidadTotal > existencias * 0.75
    order by cantidadTotal;

-- 32
select count(distinct oficina)
	from empleados
    where ventas>cuota;






    