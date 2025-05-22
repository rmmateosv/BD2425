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

delimiter ;