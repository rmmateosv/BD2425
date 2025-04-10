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

-- Rutina que crea entrega
drop procedure crearEntrega//
create procedure crearEntrega(pSocio int,
	pProducto varchar(10), pKilos int, pBultos int)
begin
	declare vNumero int;
    declare vProducto varchar(10);
    declare vPrecio float;
    
	-- Chequear socio
    set vNumero = (select numero
		from socios
        where numero = pSocio);
	if vNumero is null then
		-- No se ha encontrado el socio
        signal sqlstate '45000' 
			set message_text = 'No existe el socio';
    end if;
    -- Chequear producto
    select id, precio
		into vProducto, vPrecio
		from productos
        where id = pProducto;
	if vProducto is null then
		signal sqlstate '45000' 
			set message_text = 'No existe el producto';
    end if;
    -- Crear entrega
    insert into entregas values(default, curdate(),
		vNumero,pProducto,pKilos,pBultos,
        pkilos*vPrecio);
	-- Devolver id de entrega creada
    select last_insert_id();
    
	
end//
call crearEntrega(1,'F2', 10, 5)//

use cooperativa//
drop procedure if exists actualizaSaldo//
create procedure actualizaSaldo()
begin
	declare vFin boolean default false;
    declare vNumero int;
    declare vImporteE, vImporteC float;
    
	-- Declarar el cursor
    declare cSocios cursor for select numero from socios;
    
    -- Declarar manejador de error del fetch 1329
    -- Siempre después del cursor
    declare continue handler for 1329 
    begin  
		set vFin = true;  
	end;
    
    -- Abrir cursor: Ejecuta el select y lo carga
    --  en cSocios
    open cSocios;
    -- Recorrer cursor y actualiar saldo
    e1:loop
		-- Recuperar un registro del cursor
        fetch cSocios into vNumero;
        -- Cuando vFin se true, salimos del bucle
        if vFin=true then
			leave e1;
		end if;
        -- Calcular importe entregas
        set vImporteE = (select ifnull(sum(precio),0)
							from entregas
                            where socio = vNumero);
        -- Calcular importe compras
        set vImporteC = (select ifnull(sum(precio),0)
							from compras
                            where socio = vNumero);
        -- Actualizar saldo
        update socios set saldo = vImporteE- vImporteC
			where numero = vNumero;
    end loop;
    -- Cerrar cursor
    close cSocios;
    select * from socios;
end//
call actualizaSaldo()//

drop procedure if exists atipicas//
create procedure atipicas(pSocio int)
begin
	declare vSalir boolean default false;
    declare vId int;
    declare vPrecio, precioMedio float;
    
    -- Paso 1: Declararlo
	declare cEntregas cursor for select id, precio 
									from entregas
                                    where socio = pSocio;
	declare continue handler for 1329 
		begin 
			set vSalir = true;
        end;
    -- Calcular el precio medio de las entregas del socio
    set precioMedio = (select avg(precio) from entregas where socio = pSocio);
    -- Crear la tabla si no existe
    drop table if exists tmp;
	create table tmp(
		id int primary key,
		precio float,
		tipo enum ('Atípica','Normal')
	)engine innodb;
   -- Paso 2: Abrirlo    
    open cEntregas; -- Se ejecuta el select y se carga en memoria
	-- Paso 3: Recorrerlo
    b1:loop
		fetch cEntregas into vId, vPrecio;
        if vSalir then
			leave b1; -- Salir del bucle etiquetado como b1
        end if;
       
        -- Comprobar si la entrega es atípica o no
        if vPrecio < precioMedio/100 or vPrecio > precioMedio * 100 then
			-- Atípica
            insert into tmp values (vId, vPrecio, 'Atípica');
        else
			-- Normal
            insert into tmp values (vId, vPrecio, 'Normal');
        end if;
    end loop;
    -- Paso 4. cerrarlo
    close cEntregas;
    -- Mostrar la tabla temporal
    select * from tmp;
    -- Borrar la tabla temporal
    drop table if exists tmp;
end//
call atipicas(1)//

-- TRIGGERS
-- Calcular el precio de una compra, chequeando el sado
drop trigger if exists insertCompra//
create trigger insertCompra
	before insert
    on compras
    for each row
begin
	declare vPrecio float;
    declare vSaldo int;
	-- Obtener el precio del material
    -- que se está comprando
    select precio 
		into vPrecio
		from materiales where id = new.material;
	-- Rellenar el precio del material en la compra
    set new.precio = vPrecio;
    -- Chequear si el socio tiene saldo
    -- Obtener el saldo del socio
    set vSaldo = (select saldo 
					from socios 
                    where numero = new.socio);
    if(vSaldo < (new.cantidad*new.precio)) then
		signal sqlstate '45000' 
			set message_text = 'Error, socio sin saldo';
    end if;
end//
insert into compras values (default,curdate(),1,'M4',3,34)//

-- Crear un trigger para que el saldo del socio
-- se actualice automáticamente después de hacer una compra
drop trigger if exists insertCompra2//
create trigger insertCompra2
	after insert
    on compras
    for each row
begin
	update socios set saldo = saldo - (new.cantidad * new.precio)
		where numero = new.socio;
end//    

-- Hacer que cada vez que se borre una compra, se actualice el
-- saldo del socio,
drop trigger if exists borrarCompra//
create trigger borrarCompra
	after delete
    on compras
    for each row
begin
	update socios set saldo = saldo + (old.cantidad * old.precio)
		where numero = old.socio;
end//   
delete from compras where id = 10//
delimiter ;

