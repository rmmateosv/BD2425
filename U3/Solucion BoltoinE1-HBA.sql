drop database if exists hba;
create database hba;
use hba;


create table series(
	id int auto_increment primary key,
    nombre varchar(100) unique not null,
    genero enum ('Acción', 'Suspense', 'Infantil', 'Otros') not null,
    edadR int not null
)engine innodb;

create table capitulos(
	id int auto_increment primary key,
    serie int not null,
    numero int not null,
    titulo varchar(100) not null,
    duracion int not null,
    unique(serie,numero),
    unique(serie,titulo),
    foreign key(serie) references series(id) on update cascade on delete restrict
)engine innodb;

create table usuarios(
	nick varchar(20) primary key,
    clave blob not null, -- Conunto de bytes si especificar tamaño
    email varchar(50) not null  unique,
    fechaAlta date not null,
    fechaBaja date null
)engine innodb;

create table reproducciones(
	usuario varchar(20) not null,
    capitulo int not null,
    primary key(usuario, capitulo),
    fechaR datetime not null,
    minActual int not null default 0,
    foreign key(usuario) references usuarios(nick) on update cascade on delete restrict,
    foreign key(capitulo) references capitulos(id) on update cascade on delete restrict
)engine Innodb;


-- Ejercicio 2
-- drop table usuarios;

-- Ejercicio 3
alter table usuarios 
	add column nickMejorAmigo varchar(20) null;  -- Añado campo
alter table usuarios
	add foreign key (nickMejorAmigo) 
		references usuarios(nick) 
        on update cascade on delete restrict;
        
alter table usuarios add (
	nickMejorAmigo2 varchar(20) null,
    foreign key (nickMejorAmigo2) 
		references usuarios(nick) 
        on update cascade on delete restrict
);

-- 4
alter table usuarios drop column nickMejorAmigo;        
alter table usuarios drop column nickMejorAmigo2;    

-- 6
create view serieMenores as 
	select nombre, genero
		from series
        where edadR <18;
select * from serieMenores;        
-- No puedod moficarla porque en la vista 
-- no está el campo edad.
-- sí podríamos modificar el nombre y el género
 -- Para que dejara, tendría que añadir el campo
 -- a la vista.
 -- En ese caso se podría modificar porque
 -- cada registro de la vista corresponde con
 -- una de la tabla.
 
 -- borra la vista y creala de nuevo con el campo 
 -- edad.
 drop view serieMenores;
 create view serieMenores as 
	select nombre, genero, edadR
		from series
        where edadR <18;
 -- ¿Se podría modificar la edad y poner el valor 20?
 -- Sí, porque no he puesto el modificador: WITH CHECK OPTION
 -- ¿Qué harías para que no se pudiera?
 -- Borrar la vista y volverla a crear con este modificador
 
 -- 7
 -- No, porque un registro de la vista está
 -- calculado a partir de varios registro de la tabla
 -- Para cada serie  hay que contar el nº de reproducciones
 -- 8
 drop view if exists top10;
 -- 9
 create index iGenero on series(genero);
 
 -- 10
 -- Usuarios: Tiene dos ínidices nick y email. 
 -- los dos son únicos y simples
 -- Reproducciones: Tiene 3 ínidices, 
 -- (usuario,capítulo): Compuesto y único
 -- usuario: Simple y no único
 -- capítulo: Simple y no único
 
 -- 11
 create user 'ceo'@'%' identified by 'ceo';
 grant all on *.* to 'ceo'@'%';
 
create user 'gestion'@'localhost' identified by 'gestion';
grant select, insert, update, delete on hba.* to 'gestion'@'localhost';

create user 'usuario'@'localhost' identified by 'usuario';
grant select on hba.series to 'usuario'@'localhost';
grant select on hba.capitulos to 'usuario'@'localhost';
grant select on hba.reproducciones to 'usuario'@'localhost';

-- Hay que quitar el permiso que tiene
revoke all on *.* from 'ceo'@'%';
 -- Dar el permiso de nuevo
grant all on hba.* to 'ceo'@'%';

drop user 'usuario'@'localhost';
drop user 'gestion'@'localhost';
drop user 'ceo'@'%';