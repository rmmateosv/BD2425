drop database if exists acb;
create database acb;
use acb;

create table equipo(
	nombre varchar(50) primary key,
    localidad varchar(50) not null,
    patrocinador varchar(50) null
)engine innodb;

create table jugador(
	codigo int auto_increment not null primary key,
    equipo varchar(50)  not null,
    dorsal int not null,
    nombre varchar(100) not null,
    tipo enum('Pivot', 'Base', 'Alero', 'Escolta') not null,
    puntosJugador int not null,
    foreign key (equipo) references equipo(nombre) on update cascade on delete restrict
)engine innodb;

create table partido(
	codigo int auto_increment primary key  not null,
    local varchar(50)  not null,
    visitante varchar(50)  not null,
    fecha date not null,
    duracionCuartos int not null default 10,
    aforoMaximo int null,
    foreign key (local) references equipo(nombre) on update cascade on delete restrict,
    foreign key (visitante) references equipo(nombre) on update cascade on delete restrict
)engine innodb;

create table tipoAccion(
	tipo enum('C1','C2','C3','P','D','Pa','T') primary key not null,
    descrip varchar(50) not null
)engine innodb;

create table accion(
    partido int not null,
    jugador int not null, 
    minuto int not null,
    tipo enum('C1','C2','C3','P','D','Pa','T') not null,
    anulada boolean not null,
    primary key (partido, jugador, minuto),
    foreign key (partido) references partido(codigo) on update cascade on delete restrict,
    foreign key (tipo) references tipoAccion(tipo) on update cascade on delete restrict,
    foreign key (jugador) references jugador(codigo) on update cascade on delete restrict
)engine innodb;

-- 3
alter table accion modify anulada boolean not null default false;

-- 4
-- Teoría

-- 5
create view vista_pivots as select * from jugador where tipo='pivot';

-- a
-- Si porque la vista obtiene todos los campos incluído el nombre y cada registro de la vista es un jugador por lo 
-- que hay una correspondencia 1:1 entre la tabla y la vista. Además, la vista se ha creado sin la opción
-- WITH CHECK OPTION por lo que si se modifica un nombre no se está teniendo en cuenta el where.

-- b
-- Sí, por los mismos motivos anteriores, como la vista es modificable, puedo hacer insert.
-- Además, aunque inserte un alero y la vista solamente muestra pivots, la inserción
-- se realizará correctamente porque la vista está creada sin la opción WITH CHECK OPTION

-- c
alter table jugador drop puntosJugador;
alter table accion add column puntos int not null;

create view puntos_jugador as select nombre, sum(puntos) from accion inner join jugador on jugador=codigo group by jugador;

-- Esta vista es no modificable porque muestra los nombres de los jugadores y sus puntos. Para obtener los puntos por jugador hay
-- se hace un grupo para cada jugador y se suman los puntos de sus acciones (puede haber varios registros de acciones). 

-- 5
-- Partido: Tiene 3 índices
-- Para el código: Simple y unico
-- Para el campo local:  Simple y no es único
-- Para el camo visistante:  Simple y no es único

-- Acción: Tiene 4 ínidices
-- PAra la clave primaria (partido,jugador,minuto): Es único y compuesto
-- Para partido:  Es no único y simple
-- Para jugador:  Es único y simple
-- Para tipo:  Es único y simple

-- 6
-- Crear un índice para el campo tipo de jugador ya que la vista hace un select a la tabla jugador y en el where utiliza el campo tipo
create index iTipo on jugador(tipo);
-- Teoría para explicar los inconvenienes.

-- 7
create user 'tecnicoACB'@'localhost' identified by 'tecnico';
grant all on *.* to 'tecnicoACB'@'localhost';

create user 'representanteEquipo'@'localhost' identified by 'repre';
grant all on acb.* to 'representanteEquipo'@'localhost';

create user 'mesa'@'%' identified by 'mesa';
grant insert, update(anulada) on acb.accion to 'mesa'@'%'; -- Una anulación solamente modifica el campo anulada

create user 'jugador'@'%' identified by 'jugador';
grant select(puntos) on acb.accion to 'jugador'@'%'; -- Los puntos está en acción ya que hemos borrado el campo de jugador y lo hemos pasado a acción


-- 8
revoke all on acb.* from 'representanteEquipo'@'localhost';
grant select, insert, update, delete on hba.* to  'representanteEquipo'@'localhost';

-- 9
drop user 'tecnicoACB'@'localhost';
drop user 'representanteEquipo'@'localhost';
drop user 'mesa'@'%'; 
drop user 'jugador'@'%';
