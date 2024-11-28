-- Trabajaremos sobre la bd biblioteca
use biblioteca;

-- Crear vista que muestre el nombre y telefono de los
-- usuarios de la biblioteca
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