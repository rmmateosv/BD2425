use cooperativa;
-- 1
insert into socios(nombre, saldo) values ('Fernández, Juan',500) ;

-- 2
insert into materiales values ('M7','Herbicida',12.5);

-- 3
start transaction;

insert into compras values(null,20250220,
		(select numero 
			from socios 
			where nombre = 'Fernández, Juan' limit 1),
		'M3',
        5,
        5 * (select precio from materiales where id = 'M3')
        );
update socios
	set saldo = saldo - 5 * 
    (select precio from materiales where id = 'M3')
    where nombre = 'Fernández, Juan';
    
commit;

-- 6
update socios
	set saldo = saldo +100;
    
-- 7
-- Declarar una variable 
set @precioMedio =  (select avg(precio) from materiales);
select @precioMedio;

update materiales
	set precio = @precioMedio
	where id = 'M1';
-- 9
update productos
	set precio = precio * 1.10
    where nombre like '%fresa%';
-- 10
update socios
	set saldo = saldo * 0.95
    where saldo < 0;
-- 11
start transaction;
delete from compras
	where material ='M2';
delete from materiales
		where id = 'M2';
commit; 
-- 13
-- Solución 1
select distinct socio
	from entregas
UNION    
select distinct socio
	from compras;    
-- Borrar socios cuyo  numero esté entre los obtenidos en la consulta anterior
delete from socios
	where numero not in (select distinct socio
								from entregas
								UNION    
								select distinct socio
									from compras);
-- Solución 2
delete from socios
	where numero not in (select distinct socio
								from entregas)
	  and numero not in (select distinct socio
									from compras);    
-- 18
-- Ids de productos con más de 5 entregas
select producto
	from entregas
    group by producto
    having count(*) > 5;
update productos
		set precio = precio * 1.1
        where id in (select producto
						from entregas
						group by producto
						having count(*) > 5);

    

