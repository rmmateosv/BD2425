drop database if exists biblioteca;
create database if not exists biblioteca;

use biblioteca;

create table libros(
	id int auto_increment primary key,
	titulo varchar(100) not null,
	autor varchar(100) not null,
	numEjemplares int not null
) engine InnoDB;

create table socios(
	id int auto_increment primary key,
	nombre varchar(100) not null,
	email varchar(100) not null unique,
	sancionado boolean default false,
	FechaSancion date null
    ) engine InnoDB;
    
create table prestamos(
	id int auto_increment primary key,
	idLibro int not null,
    idsocio int not null,
	fechaPrestamo date not null,
	fechaPrevistaDevolucion date not null,
	fechaRealDevolucion date null,
    constraint fk1 foreign key (idLibro) references libros(id),
    constraint fk2 foreign key (idSocio) references socios(id)
)engine InnoDB;
