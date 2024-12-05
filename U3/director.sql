-- Soy director
use ies;
-- Añadir un campo a la tabla persona 
-- para saber si está o no actualmente en el instituto
alter table personas add activo boolean default true;

-- Mostrar personas
select * from personas;

-- Crear un usuario secretario
create user 'secretario'@'%' identified by 'secretario';
-- No puede crear usuarios porque este permiso no lo tiene

-- Crear tabla amonestacion
create table amonestacion(
	id int auto_increment primary key,
    alumno int not null,
    fecha date not null
)engine Innodb;