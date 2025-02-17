-- Crear BD Ventas
drop database if exists ventas;
create database ventas;
use ventas;

create table productos(
	id int primary key auto_increment,
    nombre varchar(50) not null,
    descripcion varchar(100) null,
    precio float not null,
    stock int not null default 1,
    creado_en timestamp default CURRENT_TIMESTAMP,
    constraint check (stock >= 0)
)engine innodb;

create table ventas(
	id int primary key auto_increment,
    producto_id int not null,
    cantidad int not null,
    total float not null,
    vendido_en timestamp default CURRENT_TIMESTAMP,
    foreign key (producto_id)  references productos(id)
		on update cascade on delete restrict
)engine innodb;

-- Insertar 3 productos indicando los campos
-- que se deben especificar
insert into productos(descripcion,nombre,precio,stock) values 
('Monitor 15"','Monitor LG15', 40.00, 3),
('Disco NVME 2TB','NVME 2TB',100,default),
(null,'Ratón Inalámbrico',15.50,50);

select * from productos;

-- Insertar 2 productos sin especificar campos
-- Hay que respetar el orden!!!!
insert into productos values
	(default,'Teclado USB',null,12,default,default),
    (default,'Portátil HP Modelo TR44','1TB,16GB RAM,I7 12g',
		1000,1,default);      
        
-- UPDATE
-- Modificar el stock del producto 1 y poner 50 unidades
update productos
	set stock = 50
    where id = 1;
-- Modicar el stock del producto 1 y aumentar en 10 
-- unidades
update productos
	set stock = stock + 10
    where id = 1;    
-- Aumentar en 10 unidades el stock de todos
-- los productos
update productos
	set stock = stock + 10;
    
-- Disminuir en 10 el stock de todos los productos
update productos
	set stock = stock - 10;
-- Modificar el precio de los productos de los que 
-- solamente hay una unidad para rebajar el precio
-- un 10%. Modificar la descripción y añadir 'Rebajado'     
--  a la descripción que tiene 
update productos
	set precio = precio * 0.90,
		descripcion = concat_ws('-','REBAJADO',descripcion)
	where stock = 1;
    
-- DELETE
-- Borrar los productos cuyo stock
-- esté entre 1 y 15 unidades
delete from productos
	where stock between 1 and 15;
    
-- Borrar todos los productos
delete from productos;

-- 1
-- Crear 5 productos con precios y stocks aleatorias
-- Sin descripiciones
insert into productos(nombre, precio, stock) values
	('Producto 1',rand()*5000, rand()*100),
    ('Producto 2',rand()*5000, rand()*100),
    ('Producto 3',rand()*5000, rand()*100),
    ('Producto 4',rand()*5000, rand()*100),
    ('Producto 5',rand()*5000, rand()*100);

-- 2
-- Modificar los productos y ponerles como descripción
-- El texto ID:? - Precio:? - Stock:?
update productos
	set descripcion = concat_ws(' - ',
						concat_ws(':','ID',id),
                        concat_ws(':','Precio',precio),
                        concat_ws(':','Stock',stock));
-- 3
-- Modificar la fecha de creación de los productos
-- con id 6, 7 y 8 y ponerle la misma fecha pero 
-- del año pasado
update productos
	set creado_en = subdate(creado_en, interval 1 year)
    where id in (6, 7, 8);
-- 4
-- Crear dos ventas en dos meses distintos para el producto 
-- 6. El precio no se puede poner a mano, se debe coger de 
-- la tabla productos
insert into ventas values
	(default,6, 3, 
		3 * (select precio from productos where id = 6),
		subdate(current_timestamp(), interval (rand() * 10) month )
	),
	(default, 6, 1, 
		1 * (select precio from productos where id = 6),
		subdate(current_timestamp(), interval (rand() * 10) month )
	);

-- 5
-- Crea una tabla llamada descatalogados
-- La tabla debe almacenar el id del producto,
-- el nombre y la fecha en la que se crea el registro.
-- Rellena la tabla con los productos que 
-- no tengan ventas.
-- Borra de la tabla productos los productos que 
-- estén descatalogados
