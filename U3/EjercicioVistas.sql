drop database if exists ies;
create database ies;
use ies;

create table personas(
	id int primary key auto_increment,
    expediente int unique null,
    tipo enum('profesor', 'alumno','conserje') not null,
    fechaNac date not null,
    cp int default 10300 not null,
    nombre varchar(50) not null
)engine innodb;

insert into personas values
(1,null,'profesor',20000101,default, 'Pedro'),
(5,null,'profesor','1998-08-09',10100, 'María'),
(null,1000,'alumno','2005-04-24',default, 'Iván'),
(null,1001,'alumno','2006-05-14',default, 'Lucía'),
(null,1002,'alumno','2007-06-04',default, 'Sara'),
(null,null,'conserje','1997-06-04',default, 'Rocío'),
(null,1003,'alumno','2007-06-04',10400, 'Carlos');

-- Crea la vista alumnos de navalmoral de forma que no
-- se puedan añadir otros tipos de personas
create view alumnosN as 
	select nombre, fechaNac, expediente, tipo
		from personas
        where cp = 10300 and tipo='alumno'
	with check option;
        
-- Mostrar los datos de la vista
select * from alumnosN;
-- Insertar un alumno en la vista
insert into alumnosN
	values ('Isabel',20000321,2034,'alumno');
-- Insertar un profesor en la vista       
insert into alumnosN
	values ('Isabel',19900321,null,'profesor');