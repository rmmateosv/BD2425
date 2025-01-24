-- Funciones de agregación o de resumen o de totales
-- sum, avg,, count, max y min

use bd_empresa;

-- Mostrar el nº de pedidos, el importe recaudado
-- la cantidad media pedida, el precio medio de los productos
-- el importe  del pedido más alto y el importe del pedido más bajo
select count(*) NumPedidos, sum(importe) Recaudación,
	avg(cantidad) CantidadMedia, avg(importe/cantidad) PrecioMedio,
    max(importe) PrecioMayor, min(importe) PrecioMenor
	from pedidos;
    
-- Mostrar cuántos pedidos ha hecho cada empleado
-- Mostrar el nº de empleado y el nº de pedidos
-- Ordena el listado por nº de empleado
select representante, count(*)
	from pedidos
    group by Representante
    order by Representante;

-- Idem, pero mostrar también el nombre del empleado
select representante, nombre, count(*)
	from pedidos join empleados on representante = NumEmp 
    group by Representante
    order by Representante;
    
-- Contar cuántos fabricantes hay en los pedidos
select count(fabricante)
	from pedidos;
-- Idem, pero que no cuente duplicados    
select count(distinct fabricante)
	from pedidos;
    
-- Contar cuántos directores de oficinas hay
select count(dir)
	from oficinas;
-- Contar cuántos directores distintos de oficinas hay
select count(distinct dir)
	from oficinas;    
    
-- Mostrar cuántos productos distintos se ha 
-- pedido de cada fabricante y el importe de todos ellos
select fabricante, count(distinct producto), sum(importe)
	from pedidos
    group by Fabricante;

-- Idem, pero mostrar solamente si se han vendido
-- 3 o más de tres productos distintos
select fabricante, count(distinct producto) as numProd, sum(importe)
	from pedidos
    group by Fabricante
    having numProd >= 3;   

-- Mostrar cuántos productos distintos  y el importe de todos ellos    
-- de los fabricante aci, bic, fea.
-- Los datos deben salir agrupados por fabricante
select fabricante, count(distinct producto), sum(importe)
	from pedidos
	where fabricante in ('aci', 'bic', 'fea')
    group by Fabricante;
--  ¡¡AUNQUE SALE = ESTO ES UN GRAN ERROR 
--  ¡¡LA CONDICIÓN SE DEBE HACER ANTES DE LA AGRUPACIÓN
--  ¡¡DE ESTA FORMA SE SELECCIONAN ÚNICAMENTE LOS REGISTROS NECESARIOS
--  ¡¡QUE DEBEN AGRUPARSE
select fabricante, count(distinct producto), sum(importe)
	from pedidos
    group by Fabricante
    having fabricante in ('aci', 'bic', 'fea'); -- !!ERROR => ES UN WHERE