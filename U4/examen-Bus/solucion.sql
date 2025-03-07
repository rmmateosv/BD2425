-- 1 Obtener los servicios realizados el mes de marzo
select *
	from  servicios
    where month(fecha)=3;
    
-- 13 Modelo 2:
-- Obtener los servicios realizados el mes de marzo. 
-- Debes mostrar el id del servicio, la fecha, el nombre de la línea, 
-- el nombre del conductor y la recaudación. 
-- Los datos deben salir ordenados por fecha y por línea
select s.id, s.fecha, l.nombre, c.nombreApe, s.recaudacion
	from  servicios s join lineas l on s.linea = l.id
          join conductores c on s.conductor = c.id
    where month(fecha)=3
    order by fecha, linea;
    
-- 2/9 
-- Mostrar cuántos tipos de billetes hay
select count(*)
	from tiposbilletes;
-- 3/17
-- Mostrar el precio actual de cada tipo de billete. 
-- Debes mostrar el id del tipo, el tipo, desde qué fecha está vigente 
-- y el precio
select t.id, t.tipo, p.fechainicio, p.precio
	from tiposbilletes t join preciosbilletes p on t.id = p.tipo
    where fechafin is null;
-- 4/12
-- Mostrar cuántos billetes se han vendido de cada tipo. 
-- Muestra el tipo (no el id, el tipo) y el nº de billetes vendidos. 
-- Debes tener en cuenta que los billetes anulados son como si no se hubieran 
-- vendido
select t.tipo, count(*)
	from billetes b join tiposbilletes t on b.tipo = t.id
    where anulado = false
    group by t.id;

-- 5/15
-- Mostrar los datos de los servicios que ha realizado 
-- Ana Torres en la línea 3
select s.*
	from  servicios s join conductores c on s.conductor = c.id
    where c.nombreApe='Ana Torres' and s.linea  = 3;
-- 6/7
-- Mostrar todos los datos del conductor más antiguo (Puede que haya más de uno)
select * 
	from conductores
    where fechaContrato = (select min(fechaContrato) from conductores);
-- 7/20
-- Mostrar el nº de billetes vendidos de forma efectiva 
-- y el nº de billetes anulados
select count(*) as vendidos, (select count(*) as vendidos
									from billetes
									where anulado = true) anulados
	from billetes
    where anulado = false;
select (select count(*) as vendidos
	from billetes
    where anulado = false),(select count(*) as vendidos
									from billetes
									where anulado = true)    ;
select if(anulado,'Anulado','Vendido'), count(*)    
	from billetes
    group by anulado;
-- 8/6
-- Mostrar todos los datos de las líneas que no tienen servicios
select l.*
	from lineas l left join servicios s on l.id = s.linea
    where s.id is null;
-- 9/2
-- Mostrar el nº de servicios realizados y la recaudación de cada línea. 
-- Debes mostrar el nombre de la línea y los dos datos anteriores. 
-- Ordena los datos por recaudación de forma que aparezcan primero las 
-- líneas que más recaudan
select l.nombre, count(*), sum(recaudacion) as r
	from lineas l left join servicios s on l.id = s.linea
    group by l.id
    order by r desc;
-- 10/11
-- Mostrar los tipos de billetes y el nº de billetes vendidos. 
-- Deben aparecer todos los tipos, aun cuando no se haya vendido nada
select t.tipo, count(b.id)
	from billetes b right join tiposbilletes t on b.tipo = t.id
    group by t.id;
--  Teniendo en cuenta solamente billetes efectivos
select t.tipo, count(b.id)
	from billetes b right join tiposbilletes t on b.tipo = t.id
    where b.anulado = false or b.anulado is null
    group by t.id;    
-- 11/14
-- Mostrar las líneas en las que han trabajado los conductores 
-- que se apellidan Luna. Debe Mostrar el nombre del conductor 
-- y el origen y el destino de la línea separados por un guion 
-- (Centro-Estación). No deben salir duplicados. 
-- Los datos deben salir ordenados alfabéticamente
select distinct c.nombreApe nombre, concat_ws('-',l.origen,l.destino) ruta
	from lineas l left join servicios s on l.id = s.linea
		join conductores c on s.conductor = c.id
	where c.nombreApe like '%Luna%'
    order by nombre, ruta;
-- 12/3
-- Mostrar para cada servicio el nº de billetes anulados. 
-- Solamente deben salir los servicios para los que se han anulado 
-- más de 5 billetes. Debes mostrar el id del servicio y el nº de 
-- billetes anulados. Ordenar los datos de forma que salgan primero 
-- los servicios para los que se han anulado más billetes
select b.servicio, count(b.anulado) as anul
	from billetes b 
    where b.anulado = true
    group by b.servicio
    having anul >5
    order by anul desc;

-- 13/10
-- Mostrar para los servicios de 01/12/2024 la recaudación 
-- y el importe recaudado de los billetes vendidos efectivamente
--  en el servicio. Además, debes mostrar un campo que indique si 
-- son iguales o diferentes
select s.id, s.recaudacion as reca, sum(b.precio) as totalb,
	if(s.recaudacion=sum(b.precio),'Iguales','Disitintos')
	from billetes b join servicios s on b.servicio = s.id
    where b.anulado = false and date(s.fecha) = '2024-12-01'
    group by s.id;
-- 14/5
-- Mostrar el importe más alto recaudado en una línea.
select max(sc.total) from (select linea, sum(recaudacion) as total
	from servicios
    group by linea) as sc;
-- 15/18
-- Mostrar las líneas que tengan algún servicio en el que se 
-- haya recaudado más que en todos los servicios de la línea 1. 
-- Debes mostrar el id de la línea y el importe recaudado. 
-- No deben salir duplicados
select linea, recaudacion
	from servicios
    where recaudacion > ALL (select recaudacion from servicios where linea = 1);
select linea, recaudacion
	from servicios
    where recaudacion >  (select max(recaudacion) from servicios where linea = 1);    
-- 16 / 16
-- Mostrar para cada línea, el id de la línea, el nº de servicios, 
-- la recaudación total de la línea, 
-- el nº de billetes vendidos de forma efectiva, 
-- el total de los billetes vendidos de forma efectiva
select linea, count(distinct s.id), sum(recaudacion), count(*), sum(precio)
	from servicios  s join billetes b on b.servicio = s.id
    where anulado = false
    group by s.linea;
	
-- 17/1
-- Mostrar el nombre de los conductores que han trabajado en las líneas 
-- con origen o destino en el Hospital
select distinct c.nombreApe
	from conductores c join servicios s on c.id = s.conductor
		join lineas l on s.linea = l.id
	where l.origen = 'Hospital' or l.destino = 'Hospital';
-- 18/4
-- Mostrar el nombre de los conductores que han trabajado en líneas 
-- en las que se ha recaudado más de 29000 euros
select distinct c.nombreApe
	from conductores c join servicios s on c.id = s.conductor
		where linea in (select linea 
							from servicios 
                            group by linea 
                            having sum(recaudacion)>29000);
-- 19/19
-- Mostrar los datos de los conductores que no han realizado ningún servicio
select c.*
	from conductores c left join servicios s on c.id = s.conductor
    where s.id is null;
-- 20/8
-- Mostrar para los servicios de la línea 1 realizados el 30/03/2024 el id,
--  la recaudación y el % que supone esa recaudación 
-- respecto a la recaudación más alta de esa línea
select s.id, s.recaudacion, s.recaudacion *100 / (select max(recaudacion)
													from servicios
                                                    where linea = 1 )
	from servicios s
    where date(fecha) = '2024-03-30' and linea = 1;