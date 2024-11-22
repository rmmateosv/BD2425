drop database if exists ejercicio4;
create database ejercicio4;
use ejercicio4;

create table paciente(
	codigo int auto_increment primary key,
    nombre varchar(50) not null,
    direccion varchar(200) not null,
    fechaNac date not null
)engine InnoDB;
insert into paciente values
	(null,'Rosa','C\La Línea,23','2000-01-01'),
	(null,'Ana','C\ Antonio Concha s/n','2000-10-01'),
	(null,'Marta','Avda. de la Vera,34','2000-08-08');

create table medico(
	numColegiado int primary key,
    dni varchar(9) unique not null, -- Definimos dni como clave alternativa
    nombre varchar(50) not null,
    especialidad varchar(50) not null
)engine InnoDB;
insert into medico values
(1234,'1A','Laura Sánchez','Primaria'),
(5467,'1B','Pedro Sánchez','Dermatólogo'),
(2346,'1C','Yolanda Sánchez','Otorrino');

-- Comprobar la restricción de clave primaria
-- Esta sentencia falla porque ya hay un médico con nº col 1234
-- insert into medico values
-- 	(1234,'Marta Sánchez','Traumatología');

-- Comprobar la restricción de clave alternativa
-- Esta sentencia falla porque ya hay un médico con dni 1A
-- insert into medico values
-- 	(9999,'1A','Marta Sánchez','Traumatología');
create table cita(
	paciente int not null,
    medico int not null,
    fechaH datetime not null,
    diagnostico varchar(200) null,
    constraint pk_cita primary key(paciente, medico, fechaH),
    constraint fk_paciente foreign key (paciente) 
		references paciente(codigo)
        on update cascade on delete restrict,
	constraint fk_medico foreign key (medico) 
		references medico(numColegiado)
        on update cascade on delete restrict
)engine InnoDB;
-- Insertar registros en cita
insert into cita values
(2,2346,'2024-11-13 12:00:00','Dermatitis'),
(1,1234,'2024-11-15 10:00:00',null),
(3,1234,'2024-11-15 11:00:00',null);



