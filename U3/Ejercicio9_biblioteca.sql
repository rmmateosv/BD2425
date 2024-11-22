drop database if exists biblioteca;
create database biblioteca;
use biblioteca;

create table autor(
	codigo int auto_increment primary key,
    nombre varchar(50) unique not null
)engine InnoDB;

insert into autor values
(1,'Cervantes'),
(2,'Javier Cercas'),
(3,'Eloy Moreno'),
(4,'Pablo Neruda');

create table libro(
	codigo varchar(10) primary key,
    isbn varchar(20) unique not null,
    titulo varchar(50) not null,
    editorial varchar(50) not null,
    numPaginas int not null default 1,
    constraint check_numP check (numPaginas > 0) -- Debe ser >0
)engine InnoDB;
insert into libro values
('l1', '959-332211','Don Quijote de la Mancha','Alfaguara',920),
('l2', '959-332212','El cuco de cristal','Santillana',200),
('l3', '959-332213','Redes','Anaya',176),
('l4', '959-332214','Soldados de Salamina','Santillana', 100);


insert into libro values
('l5', '959-332266','la celestina','Alfaguara',default);

insert into libro(codigo, isbn,titulo,editorial) values
('l6', '959-332288','El lazarillo de Tormes','Alfaguara');

create table autor_libro(
	autor int not null,
    libro varchar(10) not null,
    primary key (autor, libro),
    foreign key (autor) references autor(codigo) 
		on update cascade on delete restrict,
	foreign key (libro) references libro(codigo)
		on update cascade on delete restrict
)engine InnoDB;
insert into autor_libro values
(1,'l1'),
(3,'l2'),
(2,'l3'),
(3,'l3'),
(2,'l4');
-- Comprobar la integridad referencial
-- estas sentencias fallan porque no existe el autor
-- y porque no existe el libro
-- insert into autor_libro values
-- (200,'l4'); -- El autor 200 escribe el libro l4
-- insert into autor_libro values
-- (2,'l49'); -- El autor 2 escribe el libro l49

create table ejemplar(
	libro varchar(10) not null,
    ejemplar int not null,
    localizacion varchar(10) not null,
    primary key(libro,ejemplar),
    foreign key (libro) references libro(codigo)
		on update cascade on delete restrict 
)engine InnoDB;
insert into ejemplar values
('l1',1,'E1-B1'),
('l1',2,'E1-B1'),
('l1',3,'E1-B1'),
('l2',1,'E1-B5'),
('l2',2,'E1-B5'),
('l2',3,'E1-B5'),
('l3',1,'E10-B5'),
('l3',2,'E10-B5'),
('l3',3,'E10-B5'),
('l4',1,'E21-B5'),
('l4',2,'E21-B5'),
('l4',3,'E21-B5');

create table usuario(
	codigo int auto_increment primary key,
    nombre varchar(50) not null,
    direccion varchar(100) not null,
    telefono varchar(9) not null
)engine innodb;

insert into usuario values
(1,'Pedro Pérez','C\Alegría, 33', '927665544'),
(2,'Ana Pérez','C\Pena, 33', '927665555'),
(3,'Lucía Pérez','C\Esperanza, 33', '927665566'),
(4,'Luis Pérez','C\Empatía, 33', '927665577');

create table prestamo(
	libro varchar(10) not null,
    ejemplar int not null,
    usuario int not null,
    fechaP date not null,
    fechaD date null,
    primary key(libro,ejemplar,usuario,fechaP),
    foreign key(libro,ejemplar) references ejemplar(libro,ejemplar)
		on update cascade on delete restrict,
	foreign key(usuario) references usuario(codigo)
		on update cascade on delete restrict
)engine innodb;

insert into prestamo values
('l1',3,4,curdate(),null),
('l1',3,4,20230101,'2023-01-30');

-- Mostrar estructura de tabla
desc usuario;
desc libro;
desc prestamo;
-- Agregar atributo
alter table autor 
	add column nacionalidad varchar(3) null;
desc autor;
select * from autor;
-- Modifica atributo
alter table autor modify column nombre varchar(150) not null;
desc autor;

-- Renombrar atributo
alter table autor change column nombre nombreAutor 
	varchar(150) not null;
desc autor;

-- Eliminar columna
alter table autor drop column nacionalidad;

desc autor;

-- Copiar tabla , sólo estructura
create table autor2 like autor;
select * from autor2;
desc autor2;

-- Copiar tabla, estructura y datos
create table autor3 as select * from autor;
select * from autor3;
desc autor3;

drop table autor2;
drop table autor3;




