-- Crear la base de datos
drop database if exists ejercicio1;
create database ejercicio1;
-- Seleccionar la base de datos para trabajar en ella
use ejercicio1;

create table cliente(
	dni varchar(9) primary key,
    nombre varchar(50) not null,
    apellidos varchar(100) not null,
    direccion varchar(200) not null,
    fechaN date not null
)engine='InnoDb';

create table proveedor(
	nif varchar(9) primary key,
    nombre varchar(50) not null,
    direccion varchar(200) not null
)engine InnoDB;

create table producto(
	codigo int unsigned auto_increment primary key,
    nombre varchar(20) not null,
    precioUdad float not null,
    nifProveedor varchar(9) not null,
    constraint fk_prov foreign key(nifProveedor) 
		references proveedor(nif) 
        on update cascade on delete restrict
)engine InnoDB;

create table compra(
	dniCliente varchar(9) not null,
    codigoProducto int unsigned not null,
    fechaCompra datetime not null,
    constraint pk_compra 
		primary key(dniCliente,codigoProducto,fechaCompra),
	constraint ce_dniCliente foreign key (dniCliente)
		references cliente(dni) on update cascade on delete cascade,
	foreign key (codigoProducto) references producto(codigo)
		on update cascade on delete cascade
)engine InnoDB;


