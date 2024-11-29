-- Trabajaremos sobre la bd biblioteca
use biblioteca;

-- Crear vista que muestre el nombre y telefono de los
-- usuarios de la biblioteca
drop view if exists datosus;
create view datosUS as
	select nombre, telefono
		from usuario;
        
-- Mostrar datos de vista
select * from datosUS;

-- Mostrar usuarios de la vista cuyo nombre empieza
-- por l
select * from datosUS
	where nombre like 'L%';
-- Modificar el nombre de Lucía Pérez por Lucía Sánchez
-- ¿Es posible?     
-- Sí porque el registro de Lucía de la vista se 
-- corresponde solamente con un registro de la tabla
update datosUS set nombre = 'Lucía Sánchez'
	where nombre = 'Lucía Pérez';
    
-- Mostrar los datos del tabla usuario
select * from usuario;
-- Vemoos que los datos se han modificado en la tabla
-- Modifca el nombre de Pedro Pérez por Pedro Ruíz
-- en la tabla usuario
update usuario set nombre = 'Pedro Ruíz'
		where codigo = 1;
-- Está Pedro Ruíz en la vista?
select * from datosus;        

-- Crear una nueva tabla en biblioteca
drop table salas;
create table salas(
	id int primary key auto_increment,
    planta int default 1,
    sala varchar(10) not null
)engine innodb;
insert into salas values
	(null,1,'Sala 1'),
    (null,1,'Multimedia'),
    (null,1,'Wifi'),
    (null,2,'LibrosM'),
    (null,2,'LibroA'),
    (null,2,'Café');
select * from salas;
-- Crear una vista con los nombres de salas y la planta 
-- de la planta 1  
drop view if exists v1;  
create view v1 as select sala, planta
	from salas
    where planta = 1;
-- És actualizable la vista? Por qué?
-- Sí, porque un registro de la vista solamente corresponde 
-- a un registro de la tabla.
select * from v1;
-- Para comporbarlo vamos a cambiar el nombre de sala wifi por 
-- wifi2
update v1 set sala = 'Wifi2' where sala = 'wifi';
select * from v1;
select * from salas;

-- Puedo insertar en la vista salas en la planta 2?
-- Sí, porque hemos creado la vista sin la opción
-- with check option
-- Lo comprobamos insertando la sala cocina en la planta 2
insert into v1(planta,sala) values (2,'cocina');
insert into v1(sala) values ('baño');
select * from v1;
-- No aparece cocina, porque la vista solo muestra
-- las salas de la planta 1 y cocina está en la planta 2.
-- a pesar de que sí me ha dejado insertarlo en la vista.
select * from salas;
-- vemos que en la tabla sí está la nueva sala concina en la
-- planta 2.

-- Si puedo, cómo harías para que no se pueda?
-- Habría que crear la vista con la opción with check option
drop view if exists v1;
create view v1 as select sala, planta
	from salas
    where planta = 1
    with check option;
-- Para comprobarlo insertamos un nueva sala en la planta 2
insert into v1 values ('ropero',2);  -- FAlla
insert into v1 values ('ropero',1);  -- Bien

-- Crea una nueva vista que puestre el nº de salas por planta
create view v2 as 
	select planta, count(*) as numSalas
		from salas
        group by planta;
-- Visalizar datos de la vista
select * from v2;

-- Es acutualizable esta vista?
-- No, porque 1 registro de la vista no se corresponde
-- con un registro de la tabla
-- Para comprobarlo vamos a intentar modifcar
-- la planta nº 2 por la 200
update v2 set planta =200
	where planta=2;
