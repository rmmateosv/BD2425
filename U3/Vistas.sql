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
-- Crear una vista con los nombres de salas 
-- de la planta 1    

-- És actualizable la vista? Por qué?

-- Puedo insertar en la vista salas en la planta 2?

-- Si puedo, cómo harías para que no se pueda?
-- o si no puedo cómo harías para que se pudiera?