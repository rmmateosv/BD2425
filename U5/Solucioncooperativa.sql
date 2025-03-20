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
                                    
-- 14
-- Averigura el socio con saldo más alto
select numero
	from socios
    order by saldo desc
    limit 1;
-- Averiguar el id del meterial de precio menor
select id
	from materiales
    order by precio
    limit 1;
-- El precio menor
select min(precio)
	from materiales;
-- Insertar compra
insert into compras(fecha,socio,material,cantidad,precio) 
	values (curdate(),
		(select numero
				from socios
				order by saldo desc
				limit 1),
        (select id
			from materiales
			order by precio
			limit 1),
        2,
        2*(select min(precio)
				from materiales)
);

-- 14_2
-- Averigura el socio con saldo más alto
-- --->Averigura el saldo más alto
select max(saldo)
	from socios;
 -- --->Averigura los socios con saldo anterior   
select numero 
	from socios     
    where saldo = (select max(saldo)
						from socios);
-- Averiguar el id del meterial de precio menor
select id 
	from materiales      
    where precio = (select min(precio)
						from materiales);
-- Borrar
delete from compras
	where socio IN (select numero 
						from socios     
						where saldo = (select max(saldo)
											from socios)) and
		material IN (select id 
							from materiales      
							where precio = (select min(precio)
												from materiales));  
-- 15
-- Socio con más entregas
set @socio = (select socio
	from entregas
    group by socio
    order by count(*) desc
    limit 1);
select @socio;    
    
-- Otra forma de obtener el socio con más entregas 

-- ---> Obtener nº de entragas por socios
select socio, count(*) as num
	from entregas
    group by socio;
-- ---> Obtener el nº de entregas más alto de un socio    
select max(num)
		from (select socio, count(*) as num
			from entregas
			group by socio) as sc;
-- ---> Obtener el socio cuyo nº de entregas sea el anterior
select socio
	from entregas
    group by socio
    having count(*) = (select max(num)
		from (select socio, count(*) as num
			from entregas
			group by socio) as sc)
	limit 1;
-- Producto más vendido
set @prod = (select producto
		from entregas
        group by producto
        order by count(*) desc
        limit 1);       
select @prod;
-- Precio
set @precio = (select precio 
	from productos
    where id = (select producto
					from entregas
					group by producto
					order by count(*) desc
					limit 1 ));       
select @precio;                    
insert into entregas(fecha,kilos,bultos,socio,producto,precio) values 
	(curdate(),300,3,
    @socio,
    @prod,
    300*@precio);                                                
-- 17
-- Socio/s que más han comprado
select socio
	from compras
    group by socio
    having count(*) = (select max(num)
						from (select socio, count(*) as num
								from compras
                                group by socio) sc
						);
update socios as s1
	set saldo = saldo - (select sum(precio) from compras where socio = s1.numero)
    where numero in (select socio
						from compras
						group by socio
						having count(*) = (select max(num)
											from (select socio, count(*) as num
													from compras
													group by socio) sc));
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
-- 19 
-- Damos permisos a prueba@% sobre coopertiva
grant all
	on *.*
    to 'prueba'@'%';
    

start transaction;
select * from compras for update;
delete from
	compras
    where socio IN (select numero 
						from socios
						where saldo = (select min(saldo) from socios));
commit;                  
-- 20
delete from productos
	where id not in (select distinct producto from entregas);

