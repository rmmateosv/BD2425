drop database if exists comandasT6;
create database comandasT6;
use comandasT6;

create table mesas(
	numero int primary key auto_increment,
    nombre varchar(20) unique not null,
    numPersonas int not null,
    observaciones varchar(100) null
)engine innodb;

create table platos(
	id int primary key auto_increment,
    nombre varchar(50) unique not null,
    precio float not null,
    alergias enum('Gluten', 'Lactosa', 'Pescado', 'Varios') null
)engine innodb;

create table comandas(
	id int primary key auto_increment,
    fecha date not null,
    numMesa int not null,
    numComensales int not null,
    pagado boolean not null default false,
    constraint fk_mesa foreign key(numMesa) references mesas(numero) on update cascade on delete restrict
)engine innodb;

create table detalleComanda(
	idComanda int not null,
    idPlato int not null,
    cantidad int not null,
    precioUnidad float not null,
    primary key (idComanda, idPlato),
    constraint fk_comanda foreign key(idComanda) references comandas(id) on update cascade on delete restrict,
    constraint fk_plato foreign key(idPlato) references platos(id) on update cascade on delete restrict
)engine innodb;

insert into mesas(nombre, numPersonas,observaciones) values 
	('Homer', 4, 'Reservada 4 pax'),
    ('Marge', 8, null),
    ('Bart', 2, 'Reservada 2 + bebé'),
    ('Lisa', 6, null),
    ('Maggie', 4, null),
    ('Señor Burns', 4, null),
    ('Moe', 6, null),
    ('Flanders', 6, null),
    ('Milhouse', 10, 'Reservada 12 pax'),
    ('Barney', 10, 'Desmontada');    
insert into platos(nombre, precio, alergias) values
		('Pimientos del piquillo rellenos de bacalao', 8.00, 'Varios'),
        ('Calamares Romana', 7.00, 'Gluten'),
        ('Montadito de lomo', 4.00, 'Gluten'),
        ('Ensaladilla rusa', 4.00, null),
        ('Croquetas de jamón', 8.00, 'Varios'),
        ('Presa Ibérica a la Plancha', 15.00, null),
        ('Lomo relleno', 18.00, null),
        ('Fruta de temporada', 3.00, null);


delimiter //
-- 1
drop procedure if exists crearMesa//
create procedure crearMesa(pNumero int)
begin
	-- Variable contador
    declare contador int default 0;
    declare maxNum int;
    
	--  Obtener el nº más alto de las mesas
    select ifnull(max(numero),0) into maxNum from mesas;
    -- O tb podría hacerse: set maxNum = (select max(numero) from mesas);
    
    -- Crear mesas
    while(contador < pNumero) do
		-- Calcular el nº de la mesa a crear
        set maxNum = maxNum + 1;
        -- Insertar mesa
        insert into mesas values (maxNum, 
			concat_ws(' ','Mesa',maxNum),
            floor(rand()*(10-2+1)+2), -- Número aleatorio entre 2 y 10
            null);
        -- Aumentar el contador
        set contador = contador + 1;
    end while;
end//

-- Crear 2 mesas
call crearMesa(2)//    

-- 2
drop procedure if exists nuevoPlatoComanda//
create procedure nuevoPlatoComanda(pMesa int, pPlato int, pCantidad int)
begin
	declare vNumero, vPlato, vComanda, vNC int;
    declare vPrecio float;
    declare vTexto varchar(100);
	-- Chequear mesa existe
    select numero, numPersonas
		into vNumero, vNC
		from mesas
        where numero = pMesa;
	if vNumero is null then
		set vTexto = concat_ws(' ' ,'Error, la mesa',pMesa,', no existe');
		-- Generar error
        signal sqlstate '45000' 
			set message_text = vTexto;
    end if;
	-- Chequear plato existe
    select id, precio
		into vPlato, vPrecio
		from platos
		where id = pPlato;
     if vPlato is null then
		set vTexto = concat_ws(' ' ,'Error, el plato',pPlato,', no existe');
		-- Generar error
        signal sqlstate '45000' 
			set message_text = vTexto;
    end if;
    -- Comprobar si hay una comanda abierta para la mesa
    select id
		into vComanda
		from comandas
        where numMesa = pMesa and fecha=curdate() and pagado=false limit 1;
	if vComanda is null then
		-- Crear comanda
        insert into comandas values (default, curdate(), pMesa, vNC,false );
        -- Recuperar el id de la comanda creada
        set vComanda = last_insert_id();
    end if;
    -- Comprobar si ya se existe el plato en detalle comanda
    set vPlato = null; -- Lo ponemos a null porque la estamos reutilizando
    -- Y puede dar problemas si ya tiene un valor y no encuentra nada en este select
    select idPlato
		into vPlato
		from detallecomanda
        where idPlato = pPlato and idComanda = vComanda;
    if vPlato is null then
		-- Debo crear un nuevo detalle
        insert into detallecomanda values (vComanda, pPlato,pCantidad, vPrecio);
    else
		-- Debo actualizar la cantidad en detallecomanda para ese plato
        update detallecomanda set cantidad = cantidad + pCantidad
			where idPlato = pPlato and idComanda = vComanda;
    end if;
    -- Mostrar los platos de la comanda
    select comandas.*, detallecomanda.* 
		from detallecomanda join comandas on id=idComanda
		where idComanda = vComanda;
end//
call nuevoPlatoComanda(2,4,2)//

-- 3
drop function if exists mesaDisponible//
create function mesaDisponible(pMesa int)
	returns boolean deterministic 
begin
	declare vNum, vId int;
    set vNum = (select numero
		from mesas
        where numero = pMesa);
	if vNum is null then 
		signal sqlstate '45000' set message_text = 'No existe la mesa';
    end if;
    -- Comprobar disponibilidad
     set vId = (select id		
		from comandas
        where nummesa = pMesa and fecha = curdate() and pagado = false limit 1);
	if vId is null then
		return true;
    end if;
	return false;
end//
select 	mesaDisponible(5)//
-- 4
-- Crear la tabla log
drop table if exists log//
create table log(
	id int primary key auto_increment,
    fecha datetime not null,
    usuario varchar(100) not null,
    accion varchar(255) not null
)engine innodb//

-- Crear trigger para creación de comanda
drop trigger  if exists crearComanda//
create trigger crearComanda
	after insert 
    on comandas
    for each row
begin
	insert into log values 
		(default,now(),user(),concat_ws(' ','Crea comanda',new.id));
end//    
insert into comandas values (default,curdate(),1,5,false)//

-- Añadir plato a comanda
drop trigger if exists addPlato//
create trigger addPlato
	after insert
    on detallecomanda
    for each row
begin
	insert into log values 
		(default,now(),user(),
        concat_ws(' ','Añade plato',new.idplato,
					'a comanda', new.idComanda));
end//
call nuevoPlatoComanda(3,1,2)//
insert into detallecomanda values 
	(1,2,4,(select precio from platos where id = 2));

--  Modificar cantidad
drop trigger if exists modificaCantidad//
create trigger modificaCantidad
	after update
    on detallecomanda
    for each row
begin
	-- Comprobar que se mofica la cantidad
    if old.cantidad != new.cantidad then
		insert into log values 
		(default,now(),user(),
        concat_ws(' ','Modifica la cantidad del plato',old.idplato,
					'de la comanda', old.idComanda,
                    'de',old.cantidad,'a',new.cantidad));
    end if;
    
end//
call nuevoPlatoComanda(3,1,10)//
update detallecomanda
	set cantidad = cantidad + 10
    where idcomanda = 4 and idplato = 1//
    
-- Borrar plato de comanda    
drop trigger if exists borrarPlato//
create trigger borrarPlato
	after delete
    on detallecomanda
    for each row
begin
	insert into log values 
		(default,now(),user(),
        concat_ws(' ','Borra el plato',old.idplato,
					'de la comanda', old.idComanda));
end//
delete from detallecomanda where idplato = 1 and idcomanda = 4;
-- 5
drop function if exists importeFacturado//
create function importeFacturado(pMes int)
	returns float deterministic
begin
	return (select ifnull(sum(cantidad*precioUnidad),0)
				from comandas join detallecomanda on idcomanda = id
				where month(fecha) = pMes and pagado=true);
end//

select importeFacturado(5) as Total//

-- 6
drop function if exists informeVIP//
create function informeVIP(pFecha date)
returns varchar(255) deterministic
begin
	-- Declaración variables
    declare vNumero, vNumPersonas int;
    declare vNombre varchar(20);
    declare vFin boolean default false;
    
    -- Declaramos el cursor
    declare cMesas cursor for select numero, nombre, numPersonas from mesas;
    -- Declaramos el manejador de error
    declare continue handler for 1329 
    begin 
		set vFin = true; 
	end;
    -- abrir cursor
    open cMesas;
    -- recorrerlo
    e1:loop
    end loop;
    -- cerrralo 
    close cMesas;
end//

