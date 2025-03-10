drop database if exists fEXf;
create database fEXf;
use fEXf;

create table Equipo(
	nombre varchar(50) primary key, 
    ciudad varchar(50) not null, 
    presupuesto float not null, 
    telefono varchar(9) not null, 
    email varchar(320) null)engine innodb;
    

create table Partido(
	codigo int primary key auto_increment,
    EquipoLocal varchar(50) not null, 
    EquipoVisitante  varchar(50) not null, 
    fecha date not null, 
    minutos int not null default 90,
    foreign key(EquipoLocal) references Equipo(nombre) on update cascade on delete restrict,
    foreign key(EquipoVisitante) references Equipo(nombre) on update cascade on delete restrict) engine innodb;


create table Jugador(
	codigo int  primary key auto_increment,
    nombre varchar(100) not null, 
    equipo varchar(50) not null,
    posicion enum ('Portero', 'Defensa', 'Delantero', 'Lateral', 'Central') not null,
    nif varchar(9) not null,
    fechaNac date not null,
    foreign key(equipo) references Equipo(nombre) on update cascade on delete restrict) engine innodb;
/*insert into jugador values
		(null, 'Jugador Navalmoral 1','Navalmoral FC', 'Portero', '11111111A',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Navalmoral 2','Navalmoral FC', 'Delantero', '22222222A',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Navalmoral 3','Navalmoral FC', 'Defensa', '33333333A',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Navalmoral 4','Navalmoral FC', 'Lateral', '44444444A',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Navalmoral 5','Navalmoral FC', 'Central', '55555555A',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Miralvalle FC 1','Miralvalle FC', 'Portero', '11111111B',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Miralvalle FC 2','Miralvalle FC', 'Delantero', '22222222B',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Miralvalle FC 3','Miralvalle FC', 'Defensa', '33333333B',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Miralvalle FC 4','Miralvalle FC', 'Lateral', '44444444B',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Miralvalle FC 5','Miralvalle FC', 'Central', '55555555B',date_sub(curdate(), interval (6570+rand()*1000) day)),
       (null, 'Jugador Mérida FC 1','Mérida FC', 'Portero', '11111111G',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Mérida FC 2','Mérida FC', 'Delantero', '22222222G',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Mérida FC 3','Mérida FC', 'Defensa', '33333333G',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Mérida FC 4','Mérida FC', 'Lateral', '44444444G',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Mérida FC 5','Mérida FC', 'Central', '55555555G',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Cáceres FC 1','Cáceres FC', 'Portero', '11111111C',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Cáceres FC 2','Cáceres FC', 'Delantero', '22222222C',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Cáceres FC 3','Cáceres FC', 'Defensa', '33333333C',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Cáceres FC 4','Cáceres FC', 'Lateral', '44444444C',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Cáceres FC 5','Cáceres FC', 'Central', '55555555C',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Diocesano 1','Diocesano', 'Portero', '11111111D',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Diocesano 2','Diocesano', 'Delantero', '22222222D',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Diocesano 3','Diocesano', 'Defensa', '33333333D',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Diocesano 4','Diocesano', 'Lateral', '44444444D',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Diocesano 5','Diocesano', 'Central', '55555555D',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Badajoz FC 1','Badajoz FC', 'Portero', '11111111E',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Badajoz FC 2','Badajoz FC', 'Delantero', '22222222E',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Badajoz FC 3','Badajoz FC', 'Defensa', '33333333E',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Badajoz FC 4','Badajoz FC', 'Lateral', '44444444E',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Badajoz FC 5','Badajoz FC', 'Central', '55555555E',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Almendralejo 1','Almendralejo', 'Portero', '11111111F',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Almendralejo 2','Almendralejo', 'Delantero', '22222222F',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Almendralejo 3','Almendralejo', 'Defensa', '33333333F',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Almendralejo 4','Almendralejo', 'Lateral', '44444444F',date_sub(curdate(), interval (6570+rand()*1000) day)),
        (null, 'Jugador Almendralejo 5','Almendralejo', 'Central', '55555555F',date_sub(curdate(), interval (6570+rand()*1000) day));
*/
  create table TipoAccion(
	tipo varchar(1) primary key,
    descripcion varchar(255) not null)engine innodb;
       

create table Accion(
	partido int not null, 
    jugador int not null, 
    minuto int not null, 
    tipoAccion varchar(1) not null,
    primary key (partido, jugador, minuto),
    foreign key(partido) references Partido(codigo) on update cascade on delete restrict,
    foreign key(jugador) references Jugador(codigo) on update cascade on delete restrict,
    foreign key(tipoAccion) references TipoAccion(tipo) on update cascade on delete restrict)engine innodb;

alter table jugador add (sancionado boolean not null default false);

insert into equipo values 
	('Navalmoral FC', 'Navalmoral de la Mata', 10000, 611111111,null),    
    ('Miralvalle FC', 'Plasencia', 12000, 622222222,'miralvallefc@gmail.com'),
    ('Coria FC', 'Coria', 10000, 633333333,null),
    ('Cáceres FC', 'Cáceres', 15000, 644444444,'cacerescb@gmail.com'),
    ('Diocesano', 'Cáceres', 11000, 655555555,'diocesano@diocesano.com'),
    ('Mérida FC', 'Mérida', 18000, 677777777,null),
    ('Badajoz FC', 'Badajoz', 18000, 688888888,null),
    ('Almendralejo', 'Almendraleo', 15000, 699999999,null);
    
/*insert into partido values
		(null,'Navalmoral FC','Almendralejo',date_sub(curdate(), interval rand()*100 day),98),
        (null,'Navalmoral FC','Badajoz FC',date_sub(curdate(), interval rand()*100 day),default),
        (null,'Navalmoral FC','Cáceres FC',date_sub(curdate(), interval rand()*100 day),100),
        (null,'Navalmoral FC','Diocesano',date_sub(curdate(), interval rand()*100 day),92),
        (null,'Badajoz FC','Mérida FC',date_sub(curdate(), interval rand()*100 day),96),
        (null,'Mérida FC','Badajoz FC',date_sub(curdate(), interval rand()*100 day),default),
        (null,'Mérida FC','Almendralejo',date_sub(curdate(), interval rand()*100 day),default),
        (null,'Almendralejo','Navalmoral FC', date_sub(curdate(), interval rand()*100 day),default),
        (null,'Miralvalle FC','Almendralejo',date_sub(curdate(), interval rand()*100 day),92),
        (null,'Badajoz FC','Miralvalle FC',date_sub(curdate(), interval rand()*100 day),100),
        (null,'Miralvalle FC','Badajoz FC',date_sub(curdate(), interval rand()*100 day),default),
        (null,'Mérida FC','Miralvalle FC',date_sub(curdate(), interval rand()*100 day),default);*/
INSERT INTO `partido` VALUES (1,'Navalmoral FC','Almendralejo','2021-12-28',98),(2,'Navalmoral FC','Badajoz FC','2022-02-17',90),(3,'Navalmoral FC','Cáceres FC','2022-03-06',100),(4,'Navalmoral FC','Diocesano','2022-01-02',92),(5,'Badajoz FC','Mérida FC','2022-01-31',96),(6,'Mérida FC','Badajoz FC','2022-03-10',90),(7,'Mérida FC','Almendralejo','2022-03-12',90),(8,'Almendralejo','Navalmoral FC','2022-03-05',90),(9,'Miralvalle FC','Almendralejo','2022-01-28',92),(10,'Badajoz FC','Miralvalle FC','2022-03-03',100),(11,'Miralvalle FC','Badajoz FC','2022-02-15',90),(12,'Mérida FC','Miralvalle FC','2022-03-04',90);        
insert into TipoAccion values 
('Y', 'Tarjeta Amarilla'),    
('R', 'Tarjeta Roja'),    
('G', 'Gol'),    
('A', 'Asistencia de Gol'),
('F', 'Falta'); 
INSERT INTO `jugador` VALUES (1,'Jugador Navalmoral 1','Navalmoral FC','Portero','11111111A','2001-10-26',0),(2,'Jugador Navalmoral 2','Navalmoral FC','Delantero','22222222A','2001-12-05',0),(3,'Jugador Navalmoral 3','Navalmoral FC','Delantero','33333333A','2002-09-06',0),(4,'Jugador Navalmoral 4','Navalmoral FC','Lateral','44444444A','2003-05-24',0),(5,'Jugador Navalmoral 5','Navalmoral FC','Central','55555555A','2001-12-11',0),(6,'Jugador Miralvalle FC 1','Miralvalle FC','Portero','11111111B','2003-07-11',0),(7,'Jugador Miralvalle FC 2','Miralvalle FC','Delantero','22222222B','2002-01-27',0),(8,'Jugador Miralvalle FC 3','Miralvalle FC','Defensa','33333333B','2003-10-11',0),(9,'Jugador Miralvalle FC 4','Miralvalle FC','Lateral','44444444B','2002-12-10',0),(10,'Jugador Miralvalle FC 5','Miralvalle FC','Central','55555555B','2001-11-20',0),(11,'Jugador Mérida FC 1','Mérida FC','Portero','11111111G','2001-11-04',0),(12,'Jugador Mérida FC 2','Mérida FC','Delantero','22222222G','2002-01-21',0),(13,'Jugador Mérida FC 3','Mérida FC','Defensa','33333333G','2003-04-05',0),(14,'Jugador Mérida FC 4','Mérida FC','Lateral','44444444G','2003-02-23',0),(15,'Jugador Mérida FC 5','Mérida FC','Central','55555555G','2001-09-21',0),(16,'Jugador Cáceres FC 1','Cáceres FC','Portero','11111111C','2003-02-26',0),(17,'Jugador Cáceres FC 2','Cáceres FC','Delantero','22222222C','2003-08-20',0),(18,'Jugador Cáceres FC 3','Cáceres FC','Defensa','33333333C','2001-09-21',0),(19,'Jugador Cáceres FC 4','Cáceres FC','Lateral','44444444C','2001-09-09',0),(20,'Jugador Cáceres FC 5','Cáceres FC','Central','55555555C','2001-10-16',0),(21,'Jugador Diocesano 1','Diocesano','Portero','11111111D','2002-05-19',0),(22,'Jugador Diocesano 2','Diocesano','Delantero','22222222D','2002-04-16',0),(23,'Jugador Diocesano 3','Diocesano','Defensa','33333333D','2002-10-26',0),(24,'Jugador Diocesano 4','Diocesano','Lateral','44444444D','2002-12-23',0),(25,'Jugador Diocesano 5','Diocesano','Central','55555555D','2002-03-15',0),(26,'Jugador Badajoz FC 1','Badajoz FC','Defensa','11111111E','2003-04-24',0),(27,'Jugador Badajoz FC 2','Badajoz FC','Portero','22222222E','2002-12-25',0),(28,'Jugador Badajoz FC 3','Badajoz FC','Defensa','33333333E','2003-06-24',0),(29,'Jugador Badajoz FC 4','Badajoz FC','Lateral','44444444E','2004-03-17',0),(30,'Jugador Badajoz FC 5','Badajoz FC','Central','55555555E','2003-08-21',0),(31,'Jugador Almendralejo 1','Almendralejo','Portero','11111111F','2004-01-21',0),(32,'Jugador Almendralejo 2','Almendralejo','Delantero','22222222F','2002-05-25',0),(33,'Jugador Almendralejo 3','Almendralejo','Defensa','33333333F','2003-10-18',0),(34,'Jugador Almendralejo 4','Almendralejo','Lateral','44444444F','2002-01-26',0),(35,'Jugador Almendralejo 5','Almendralejo','Central','55555555F','2002-12-10',0);        
UPDATE `fexf`.`jugador` SET `fechaNac` = '2001-09-09' WHERE (`codigo` = '7');
insert into accion values
 (1,5,3,'A'),
(1,5,10,'A'),
(3,8,1,'A'),
(4,4,6,'A'),
(4,4,7,'A'),
(4,9,2,'A'),
(5,5,1,'A'),
(6,9,4,'A'),
(8,4,7,'A'),
(9,1,8,'A'),
(10,2,3,'A'),
(1,1,4,'G'),
(1,3,3,'G'),
(1,5,4,'G'),
(1,9,3,'G'),
(2,4,2,'G'),
(3,4,1,'G'),
(4,3,5,'G'),
(4,6,6,'G'),
(5,3,1,'G'),
(5,3,10,'G'),
(5,4,6,'G'),
(5,7,8,'G'),
(6,4,4,'G'),
(6,7,6,'G'),
(6,8,9,'G'),
(7,3,3,'G'),
(7,6,6,'G'),
(7,9,4,'G'),
(8,1,8,'G'),
(8,3,3,'G'),
(8,7,1,'G'),
(9,7,7,'G'),
(9,7,8,'G'),
(1,2,1,'R'),
(3,6,1,'R'),
(5,5,8,'R'),
(5,10,4,'R'),
(7,3,2,'R'),
(8,3,1,'R'),
(9,3,1,'R'),
(9,3,7,'R'),
(9,9,4,'R'),
(10,4,2,'R'),
(10,4,3,'R'),
(10,8,3,'R'),
(2,9,1,'F'),
(3,3,8,'F'),
(4,2,8,'F'),
(4,8,10,'F'),
(5,6,3,'F'),
(5,8,3,'F'),
(6,2,3,'F'),
(6,6,9,'F'),
(9,10,2,'F'),
(10,7,4,'F'),
(10,9,5,'F'),
(2,2,3,'Y'),
(2,4,4,'Y'),
(4,5,2,'Y'),
(4,9,1,'Y'),
(5,3,7,'Y'),
(6,4,5,'Y'),
(6,5,7,'Y'),
(7,4,9,'Y'),
(7,9,5,'Y'),
(8,4,8,'Y'),
(8,7,4,'Y'),
(8,9,1,'Y');
/*	(round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S');
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'Y'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'R'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'G'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'A'),
    (round(rand()*10%12),round(rand()*10%35),round(rand()*10%90),'S');*/
    
    
    UPDATE `fexf`.`accion` SET `minuto` = '30' WHERE (`partido` = '1') and (`jugador` = '3') and (`minuto` = '3');
UPDATE `fexf`.`accion` SET `minuto` = '40' WHERE (`partido` = '1') and (`jugador` = '5') and (`minuto` = '4');
UPDATE `fexf`.`accion` SET `minuto` = '54' WHERE (`partido` = '1') and (`jugador` = '9') and (`minuto` = '3');
UPDATE `fexf`.`accion` SET `minuto` = '10' WHERE (`partido` = '3') and (`jugador` = '8') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '12' WHERE (`partido` = '3') and (`jugador` = '4') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '60' WHERE (`partido` = '4') and (`jugador` = '6') and (`minuto` = '6');
UPDATE `fexf`.`accion` SET `minuto` = '20' WHERE (`partido` = '4') and (`jugador` = '5') and (`minuto` = '2');
UPDATE `fexf`.`accion` SET `minuto` = '11' WHERE (`partido` = '4') and (`jugador` = '9') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '32' WHERE (`partido` = '5') and (`jugador` = '8') and (`minuto` = '3');
UPDATE `fexf`.`accion` SET `minuto` = '15' WHERE (`partido` = '5') and (`jugador` = '3') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '45' WHERE (`partido` = '5') and (`jugador` = '7') and (`minuto` = '8');
UPDATE `fexf`.`accion` SET `minuto` = '76' WHERE (`partido` = '5') and (`jugador` = '5') and (`minuto` = '8');
UPDATE `fexf`.`accion` SET `minuto` = '41' WHERE (`partido` = '5') and (`jugador` = '10') and (`minuto` = '4');
UPDATE `fexf`.`accion` SET `minuto` = '88' WHERE (`partido` = '5') and (`jugador` = '3') and (`minuto` = '7');
UPDATE `fexf`.`accion` SET `minuto` = '23' WHERE (`partido` = '6') and (`jugador` = '4') and (`minuto` = '4');
UPDATE `fexf`.`accion` SET `minuto` = '65' WHERE (`partido` = '6') and (`jugador` = '7') and (`minuto` = '6');
UPDATE `fexf`.`accion` SET `minuto` = '90' WHERE (`partido` = '6') and (`jugador` = '8') and (`minuto` = '9');
UPDATE `fexf`.`accion` SET `minuto` = '32' WHERE (`partido` = '6') and (`jugador` = '4') and (`minuto` = '5');
UPDATE `fexf`.`accion` SET `minuto` = '11' WHERE (`partido` = '6') and (`jugador` = '5') and (`minuto` = '7');
UPDATE `fexf`.`accion` SET `minuto` = '54' WHERE (`partido` = '7') and (`jugador` = '3') and (`minuto` = '3');
UPDATE `fexf`.`accion` SET `minuto` = '36' WHERE (`partido` = '8') and (`jugador` = '3') and (`minuto` = '3');
UPDATE `fexf`.`accion` SET `minuto` = '13' WHERE (`partido` = '8') and (`jugador` = '7') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '57' WHERE (`partido` = '8') and (`jugador` = '3') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '84' WHERE (`partido` = '8') and (`jugador` = '4') and (`minuto` = '8');
UPDATE `fexf`.`accion` SET `minuto` = '44' WHERE (`partido` = '8') and (`jugador` = '7') and (`minuto` = '4');
UPDATE `fexf`.`accion` SET `minuto` = '25' WHERE (`partido` = '8') and (`jugador` = '9') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '77' WHERE (`partido` = '9') and (`jugador` = '1') and (`minuto` = '8');
UPDATE `fexf`.`accion` SET `minuto` = '22' WHERE (`partido` = '9') and (`jugador` = '10') and (`minuto` = '2');
UPDATE `fexf`.`accion` SET `minuto` = '9' WHERE (`partido` = '9') and (`jugador` = '7') and (`minuto` = '7');
UPDATE `fexf`.`accion` SET `minuto` = '19' WHERE (`partido` = '9') and (`jugador` = '7') and (`minuto` = '8');
UPDATE `fexf`.`accion` SET `minuto` = '38' WHERE (`partido` = '9') and (`jugador` = '3') and (`minuto` = '1');
UPDATE `fexf`.`accion` SET `minuto` = '55' WHERE (`partido` = '9') and (`jugador` = '3') and (`minuto` = '7');
UPDATE `fexf`.`accion` SET `minuto` = '68' WHERE (`partido` = '9') and (`jugador` = '9') and (`minuto` = '4');
UPDATE `fexf`.`accion` SET `minuto` = '31' WHERE (`partido` = '10') and (`jugador` = '4') and (`minuto` = '3');
UPDATE `fexf`.`accion` SET `minuto` = '12' WHERE (`partido` = '10') and (`jugador` = '8') and (`minuto` = '3');

