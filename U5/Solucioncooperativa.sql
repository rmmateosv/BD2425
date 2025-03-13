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

-- 11
start transaction;
delete from compras
	where material =' M2';
delete from materiales
		where id = 'M2';
commit;    
    

