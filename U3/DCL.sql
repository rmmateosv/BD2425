-- Ver los metadatos del DCL
use mysql;
-- tabla donde se guardan los priv de us a nivel de servidor
select * from user;
-- tabla donde se guardan los priv de us a nivel de bd
select * from db;

-- Ver usuarios conectados
show processlist;

-- Crear un usuario con nuestro nombre que se conecte desde
-- el localhost
create user 'rosa'@'localhost' identified by 'rosa';

-- Dar permisos a rosa para que sea un superusuario = root
grant all
	on *.*
    to 'rosa'@'localhost'
    with grant option;
    
-- mostrar la tabla user
select * from user;

-- Crear un usuario que pueda conectarse desde cualquier
-- host
create user 'rosa2'@'%' identified by 'rosa2';

-- Vamos a darle todos los permisos solamente sobre la bd
-- biblioteca
grant all
	on biblioteca.*
    to 'rosa2'@'%';
    
-- Borrar usuarios rosa y rosa2
drop user 'rosa'@'localhost';
drop user 'rosa2'@'%';

-- Añadir campo teléfono a la tabla personas de 
-- la bd ies
use ies;
alter table personas add telefono varchar(9) null;

select * from personas;

-- Añadir un teléfono (aleatorio) a cada persona
update personas set telefono = rand()*1000000000;

-- Crear un usuario director que puede hacer
-- cualquier operación sobre la bd ies
-- Además puede conceder permisos a otros usuarios
create user 'director'@'%' identified by 'director';
grant ALL
	on ies.*
    to 'director'@'%';
-- mostrar privilegios del director
show grants for 'director'@'%';
-- Me he equivocado y con este privilegio
-- no puede dar privilegios a otros usuarios
-- Quitar y volver a dar de forma correcta
revoke ALL on ies.* from 'director'@'%';    
-- mostrar privilegios del director
show grants for 'director'@'%';
grant ALL
	on ies.*
    to 'director'@'%'
    with grant option;
show grants for 'director'@'%';    
-- Crear un usuario secretario que puede hacer
-- select, insert, udate y delete sobre personas
create user 'secretario'@'%' identified by 'secretario';
grant select, insert, update, delete
	on ies.personas
    to 'secretario'@'%';
show grants for 'secretario'@'%';

-- Crear un usuario profesor que solamente puede
-- consultar el nombre y el telefono de las personas

    