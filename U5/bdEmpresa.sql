-- Borramos la base de datos
drop database if exists CentroTrabajo;
-- Creamos la Bd
create database CentroTrabajo;
-- Seleccionamos  la base de datos
use CentroTrabajo;
-- Tabla centros
create table centros(
	NumCentro int primary key auto_increment,
	Nombre varchar(50) not null,
	Direccion varchar (50) not null 
)Engine InnoDB;

create table departamentos(
	NumDepart int primary key  auto_increment,
	Nombre varchar(50) not null unique,
	Presupuesto int not null,
	Director int null,
	TipoDir  enum('P','F') not null,
	DepartDepende int null,
	Centro int null,
	foreign key(DepartDepende) 
    references departamentos(NumDepart) 
    on update cascade on delete restrict,
    foreign key(Centro) references 
    centros(NumCentro) 
    on update cascade on delete restrict
)Engine InnoDB;

create table empleados(
	NumEmp int primary key auto_increment,
	Nombre varchar(50) not null,
	NumHi Tinyint not null,
	Comision int null,
	Salario int not null,
	FecNa date not null,
	FecIn date not null,
	Extension int not null,
	Departamento int not null,
	foreign key(Departamento)
    references departamentos(NumDepart)
	on update cascade on delete restrict
)Engine InnoDB;

alter table departamentos add 
(foreign key (Director) references empleados(NumEmp) 
on update cascade on delete restrict);
