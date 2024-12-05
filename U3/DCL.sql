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
    to rosa2@;