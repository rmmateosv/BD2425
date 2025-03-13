use centrotrabajo;
-- 1
insert into centros values
(10,'Sede Central','Alcala,820,Madrid'),
(20,'Relacion con Clientes','Atocha,405,Madrid'),
(50,'Almacen', 'Lavapies,520,Madrid');

insert into departamentos values
(100,'Direccion General',120000,null,'P',null,10),
(110,'Direccion Comercial',15000,null,'P',100,20),
(111,'Sector industrial',120000,null,'F',110,20),
(112,'Sector Servicios',90000,null,'P',110,20),
(120,'Organizacion',30000,null,'F',100,10),
(121,'Personal',20000,null,'P',120,10),
(122,'Proceso de Datos',60000,null,'P',120,10),
(123,'Personal Contratado',100000,null,'P',100,10),
(130,'Finanzas',20000,null,'F',121,null);

insert into empleados values
(110,'Pons, Cesar',3,null,3100,19291110,19500215,350,121),
(120,'Lasa, Mario',1,1100,3500,19350909,19681001,840,112),
(130,'Terol, Luciano',2,1100,2900,19450909,19690201,810,112),
(150,'Perez, Julio',0,null,4400,19300810,19480115,340,121),
(160,'Aguirre, Aureo',2,1100,3100,19390709,19681111,740,111),
(180,'Perez, Marcos',2,500,4800,19341018,19560318,508,110),
(190,'Veiga, Juliana',4,null,3000,19320512,19620211,350,121),
(210,'Galvez, Pilar',2,null,3800,19400928,19590122,200,100),
(240,'Sanz, Lavinia',3,1000,2800,19420226,19660224,760,111),
(250,'Alba, Adriana',0,null,4500,19461027,19670301,250,100),
(260,'Lopez, Antonio',6,null,7200,19431203,19680712,220,100),
(270,'Garcia, Octavio',3,800,3800,19450521,19660910,800,112),
(280,'Flor, Dorotea',5,null,2900,19480111,19711008,410,130),
(285,'Polo, Otilia',0,null,3800,19491025,19680215,620,122),
(290,'Gil, Gloria',3,null,2700,19471130,19680214,910,120),
(310,'Garcia, Augusto',0,null,4200,19461121,19710115,480,130),
(320,'Sanz, Cornelio',2,null,4050,19571225,19780205,620,122),
(330,'Diez, Amelia',0,900,2800,19480819,19720301,850,112),
(350,'Campos, Aurelio',1,null,4500,19490413,19840910,610,122),
(360,'Lara, Dolinda',2,1000,2500,19581029,19681010,750,111),
(370,'Ruiz, Fabiola',1,null,1900,19670622,19870120,360,121),
(380,'Martin, Micaela',0,null,1800,19680330,19880101,880,112),
(390,'Moran, Carmen',1,null,2150,19660219,19861008,500,110),
(400,'Lara, Lucrecia',0,null,1850,19690818,19871101,780,111),
(410,'Muñoz, Azucena',0,null,1750,19680714,19881013,660,122),
(420,'Fierro, Claudia',0,null,4000,19661022,19881119,450,130),
(430,'Moran, Valeriana',1,null,2100,19671026,19921119,650,122),
(440,'Duran, Livia',0,1000,2100,19660926,19860228,760,110),
(450,'Perez, Sabina',0,1000,2100,19661021,19860228,880,112),
(480,'Pino, Diana',1,1000,2100,19650404,19860228,760,111),
(490,'Torres, Horacio',0,1000,1800,19640606,19880101,880,112),
(500,'Vazquez, Honoria',0,1000,2000,19651008,19870101,750,111),
(510,'Campos, Romulo',1,null,2000,19660504,19861101,550,110),
(550,'Santos, Sancho',0,1200,1000,19700110,19880121,780,111);

-- 2
-- Paso 1
create table empleados2 like empleados;

-- Paso 2
-- Obtener los registros que se tienen que insertar
select * 
	from empleados
    where numhi > 0 or 
		(numhi = 0 and departamento in (select numdepart
											from departamentos
                                            where length(nombre)>10));
-- Paso 3
insert into empleados2 
	select * 
	from empleados
    where numhi > 0 or 
		 departamento in (select numdepart
											from departamentos
                                            where length(nombre)>10);
-- 3
update empleados2
	set salario = salario*1.15
    where month(fecNa) =12;
    
-- 4
-- sacar edad de empleado más joven
select min(year(curdate())-year(fecNa))
	from empleados2;
    
update empleados2
	set salario = 6000,
    comision = 1000
    where year(curdate())-year(fecNa) = 
		2 * (select min(year(curdate())-year(fecNa))
				from empleados);
-- No actualiza nada porque la edad del empleado
-- más joven son 55 años y no hay ningún empleado con 110 años
select *, year(curdate())-year(fecNa)
	from empleados2;  
    
-- Para comprobar que el update acutaliza
-- vamos a poner como condición  el doble de la edad
-- del más joven menos 14 años   
update empleados2
	set salario = 6000,
    comision = 1000
    where year(curdate())-year(fecNa) = 
		2 * (select min(year(curdate())-year(fecNa))
				from empleados) - 14;
                
-- 5
delete from empleados2
	where departamento in (select numDepart 
		from departamentos
        where tipoDir = 'F');
-- 6
update empleados2
	set comision = salario/4,
    salario = salario - salario/4
	where comision is null;
-- 7
delete from empleados2
	where departamento in (select numDepart  
						from departamentos join centros 
                        on centro = numCentro
                       where direccion like '%Atocha,%');
-- 8
delete from empleados2
	where departamento in (select numDepart  
						from departamentos 
                       where centro is null);
-- No borra ninguno porque el único departamento sin centro 
-- es el 130, y no hay ningún empleado en ese departamento

-- 9
start transaction;
-- Insertar empleado
insert into empleados2 values 
	(default,'Rosa',2,null,3100,20000101,curdate(),350,130); 
-- Actualizar el presupuesto del departamento
update departamentos
	set presupuesto = presupuesto + 
		(select salario from empleados2 
			where nombre = 'Rosa' limit 1)
	where numdepart = (select departamento from empleados2 
							where nombre = 'Rosa' limit 1);
commit;   

--  10 
start transaction;
update empleados 
	set departamento = 130
    where numEmp = 290;
update departamentos
	set presupuesto = presupuesto - (select salario 
										from empleados
                                        where numEmp = 290)
	where numDepart = 120;
update departamentos
	set presupuesto = presupuesto + (select salario 
										from empleados
                                        where numEmp = 290)
	where numDepart = 130;    
commit;    

-- 11
-- Empleado de más antigüedad de un departemento
select numEmp
	from empleados
    where fecIn = (select min(fecIn) 
							from empleados 
                            where departamento = 100 );
update departamentos d
	set director = (select numEmp
						from empleados
						where fecIn = (select min(fecIn) 
												from empleados 
												where departamento = d.numdepart ));