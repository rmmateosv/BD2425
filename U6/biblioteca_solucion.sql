use biblioteca;

delimiter //

-- 1
drop procedure if exists crearSocio//
create procedure crearSocio(pNombre varchar(100), 
			pEmail varchar(100) )
begin
	declare vId int;
    
	-- Chequear que no exista otro socio
	-- con el mismo email
    set vId = (select id from socios where email = pEmail);
    if(vId is null) then
		-- Puedo crear el socio
        insert into socios(nombre, email) 
			values(pNombre,pEmail);
        -- Mostrar todos los datos del socio creado
        select *  from socios where id = last_insert_id();    
    else
		-- Error porque hay otro socio con ese email
        signal sqlstate '45000' 
			set message_text = 'Error, socio ya existe';
    end if;
end//
call crearSocio('Ana','ana@gmail.com')//

-- 2
drop procedure if exists crearLibro//
create procedure crearLibro(pTitulo varchar(100),
					pAutor varchar(100), pEjem int)
begin
	declare vTitulo varchar(100);
    declare vNumLibros int;
	select titulo 
		into vTitulo
		from libros
        where titulo = pTitulo and autor = pAutor;
	if(vTitulo is null) then
		-- Crea libro
        insert into libros 
			values (default, pTitulo,pAutor, pEjem);
		set vNumLibros = (select count(*) from libros);
		select concat_ws(' ', 
				'Libro con id',
                last_insert_id(),
                'creado. La biblioteca dispone de',
                vNumLibros,
                'libros'
                ) as Mensaje;
	else
		-- Error
        signal sqlstate '45000' 
			set message_text = 'Error, libro ya existe';
    end if;
end//

call crearLibro('Terra Alta','Javier Cercas',2)//


-- 3
drop function chequearPrestamo//
create function chequearPrestamo(pLibro int, pSocio int)
returns int deterministic
begin
	declare resultado int default  0;
	declare vId, vCont int;    
    
    -- Comprobar si socio existe y no está sancionado
    select id
		into vId
        from socios
        where id = pSocio and sancionado = false;
	if vId is null then
		-- return -1;
        set resultado = -1;
	end if;
    -- Comprobar que el socio no tiene 2 o más libros prestados
    select ifnull(count(*),0)
		into vCont
        from prestamos
        where idSocio = pSocio and fechaRealDevolucion is null;
    if vCont >=2 then
		-- return -2;
        set resultado = -2;
    end if;
	-- Comprobar si el libro existe y hay ejemplares
    set vId = null; -- La ponemos a null porque la reutilizamos
    select id
		into vId
        from libros
        where id = pLibro and numEjemplares > 0;
	if vId is null then
		-- return -3;
        set resultado = -3;
	end if;
    
    return resultado;
end//

select chequearPrestamo(0,1)//
delimiter ;