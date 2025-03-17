drop database if exists apuntesT6;
create database apuntesT6;
-- Cambiar el delimitador
delimiter //
use apuntesT6//
-- hola mundo con procediminto
create procedure holaM()
begin
	select 'Hola Mundo';
end//
-- Ejecutar el procedimiento
call holaM()//

-- hola mundo con función
create function holaM()
	returns varchar(20) deterministic
begin
	-- Zona de declaración de variables
    declare var1 varchar(20) default '';
    
    -- Zona de código de la rutina
	select 'Hola Mundo' into var1;
    return var1;
end//
select holaM()//
create function holaM2()
	returns varchar(20) deterministic
begin
    return 'Hola Mundo';
end//

select holaM2()//

-- TIPOS DE PARÁMETROS


-- Cambiar de nuevo a ;
delimiter ;


