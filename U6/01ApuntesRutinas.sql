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

-- TIPOS DE PARÁMETROS: IN/OUT/INOUT
drop procedure if exists incrementa//
create procedure incrementa(in v1 integer, out v2 integer,
							inout v3 integer)
begin
	-- Mostrar lo valores inciales de los parámetros
    select 'Valores iniciales',v1, v2, v3;
    
    -- Aumentar en 1 los valores de los parámetros
    set v1 = v1 + 1;
    if(v2 is null) then 
		set v2 = 0;
	end if;
    set v2 = v2 + 1;
    set v3 = v3 + 1;
    
    -- Mostrar lo valores modificados
    select 'Valores modificados',v1, v2, v3;
end//
-- Crear 3 variables con valores 100, 200 y 300
set @uno = 100//
set @dos = 200//
set @tres = 300//
-- Mostrar variables
select @uno, @dos,  @tres//
-- Incrementar variables con el procedimiento
call incrementa(@uno, @dos,  @tres)//
-- Mostrar variables después de incrementa
select @uno, @dos,  @tres//


-- PROCEDIMIENTO CALCULADORA
drop procedure if exists calculadora//
create procedure calculadora(in num1 integer,num2 integer, out resultado varchar(100))
begin
	declare suma int;
    declare resta int;
    declare mul int;
    declare divi float;
    
    set suma = num1 + num2;
    set resta = num1 - num2;
    set mul = num1 * num2;
    set divi =round(num1 / num2,2);
    
    set resultado = concat_ws(' ','Suma',suma,'Resta',resta,
		'Multiplicación',mul, 'División', divi);
end//

call calculadora(10,3,@r)//
select @r//

-- Idem pero con función
drop function if exists calculadora//
create function calculadora(num1 integer, num2 integer)
	returns varchar(100) deterministic
begin
	declare suma int;
    declare resta int;
    declare mul int;
    declare divi float;
    
    set suma = num1 + num2;
    set resta = num1 - num2;
    set mul = num1 * num2;
    set divi =round(num1 / num2,2);
    
    return concat_ws(' ','Suma',suma,'Resta',resta,
		'Multiplicación',mul, 'División', divi);
end//    
select calculadora(6,3)//

-- Realiza una rutina que cree un socio en la bd cooperativa
-- Que devuelva toda la información del socio creado
use cooperativa//
drop procedure if exists crearSocio//
create procedure crearSocio(pNombre varchar(45),
							pSaldo float)
begin
	insert into socios values(default, pNombre, pSaldo);
    -- Devolver la información del socio
    select *
		from socios where numero = last_insert_id();	
end//
-- Crear dos socios usando la rutina
call crearSocio('Rosa',1000)//
call crearSocio('Paco',1500)//
-- Realiza una rutina que devuelva el mensaje: 
-- El socio  X ha gastado Y y ha ingresado Z
drop function if exists infoSocio//
create function infoSocio(pNumero int)
	returns varchar(100) deterministic
begin
	-- Declarar varibles
    declare vGastos float;
    declare vIngresos float;
    declare vNumero int;
    
    -- Chequear si existe el socio
    select numero
    into vNumero
		from socios
        where numero = pNumero;
	if(vNumero is not null) then
		-- Obtener gastos
		select ifnull(sum(precio),0)
			into vGastos
			from compras
			where socio = pNumero;
		-- Obtener ingresos
		set vIngresos = (select ifnull(sum(precio),0)
							from entregas
							where socio = pNumero);
		-- Devolver el resultado
		return concat_ws(' ','El socio', pNumero, 'ha gastado',
							vGastos,'y ha ingresado ',vIngresos);
    else
		-- Socio no existe
        return 'Socio no existe';
    end if;
end//

select infoSocio(1)//

-- ESTRUCTURAS de CONTROL
-- Cambiar de nuevo a apuntesT6;
use apuntesT6//
-- Crear una rutina que muestre una cuenta atrás
-- que se inicia en un nº que se pasa por parámetro.
-- Si el nº es <= 0 debe mostrar el texto
-- 'El nº no puede ser <=0'
-- Con loop
drop procedure if exists cuentaAtras1//
create procedure cuentaAtras1(pNumero int)
begin
	-- Cuenta atrás con loop
    if pNumero <= 0 then
		select 'El nº no puede ser <=0';
    else
		b1:loop
			select pNumero;
            set pNumero = pNumero -1;
            if pNumero < 1 then
				-- Terminiar bucle
                leave b1;
            end if;            
		end loop;
    end if;
end//
call cuentaAtras1(3)//
-- Con WHile
drop procedure if exists cuentaAtras2//
create procedure cuentaAtras2(pNumero int)
begin
	-- Cuenta atrás con loop
    if pNumero <= 0 then
		select 'El nº no puede ser <=0';
    else
		while pNumero>=1 do
			select pNumero;
            set pNumero = pNumero - 1;
        end while;
    end if;
end//
call cuentaAtras2(3)//

-- Con Repeat
drop procedure if exists cuentaAtras3//
create procedure cuentaAtras3(pNumero int)
begin
	-- Cuenta atrás con loop
    if pNumero <= 0 then
		select 'El nº no puede ser <=0';
    else
		repeat
			select pNumero;
            set pNumero = pNumero - 1;
		until pNumero<1 end repeat;
    end if;
end//
call cuentaAtras3(3)//

delimiter ;

