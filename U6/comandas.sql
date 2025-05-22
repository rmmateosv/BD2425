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

insert into comandas(fecha,numMesa,numComensales, pagado) values
	(curdate(),1,4, true),
    (curdate(),3,2, true),
    (curdate(),9,12, true),
    (adddate(curdate(), interval 1 day),1,4, true),
    (adddate(curdate(), interval 1 day),2,2, true),
    (adddate(curdate(), interval 1 day),3,5, true),
    (adddate(curdate(), interval 2 day),10,8, true),
    (adddate(curdate(), interval 2 day),9,10, false),
    (adddate(curdate(), interval 3 day),5,4, true),
    (adddate(curdate(), interval 3 day),6,4, false);
insert into detalleComanda values
	(1,4,3,(select precio from platos where id = 4)),
    (1,6,2,(select precio from platos where id = 6)),
    (2,3,1,(select precio from platos where id = 3)),
    (2,5,1,(select precio from platos where id = 5)),
    (3,3,1,(select precio from platos where id = 3)),
    (3,5,2,(select precio from platos where id = 5)),
    (4,3,2,(select precio from platos where id = 3)),
    (4,5,3,(select precio from platos where id = 5)),
    (4,7,3,(select precio from platos where id = 7)),
    (4,2,3,(select precio from platos where id = 2)),
    (4,6,2,(select precio from platos where id = 6)),
    (4,4,2,(select precio from platos where id = 4)),
    (5,1,2,(select precio from platos where id = 1)),
    (5,2,1,(select precio from platos where id = 2)),
    (5,7,1,(select precio from platos where id = 7)),
    (5,4,1,(select precio from platos where id = 4)),
    (5,5,1,(select precio from platos where id = 5)),
    (6,4,1,(select precio from platos where id = 4)),
    (7,4,1,(select precio from platos where id = 4)),
    (8,4,1,(select precio from platos where id = 4)),
    (9,4,1,(select precio from platos where id = 4)),
    (10,4,1,(select precio from platos where id = 4)),
    (10,6,1,(select precio from platos where id = 6));

    