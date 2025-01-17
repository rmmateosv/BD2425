-- a
select  name, population, 
		if(population>50000000,'GRANDE','PEQUEÑO') as tipo
	from country
    where continent = 'Europe'
    order by population desc, name;
-- b
select name, ifnull(lifeexpectancy,'N/C') as EsperanzaVida
	from country
    where continent = 'Europe'
    order by LifeExpectancy desc;
-- c
select round(rand()*1000,0) numero, name nombre
	from country
    where continent = 'Europe';
-- d
select name, round(lifeexpectancy,0) as EsperanzaVida
	from country;
-- e
select concat_ws(' - ',continent,code,name,capital) as texto
	from country
    order by texto;
select concat(continent,' - ',code,' - ',name,' - ',ifnull(capital,'**')) as texto
	from country
    order by texto; 
-- f
select name, instr(name,'island') as posición
	from country;
-- g
select upper(name) Mayus, lower(name) Minus,
	left(name,3) Derecha,right(name,3) Izda,length(name) Longitud
	from country;
-- h
select rpad(name,50,'*')
	from country;
-- i
select replace(name,'Island','Isla')
	from country
    where name like '%island%';    
-- j
select substring(name,2,length(name))
		from country;     
select substring(name,2,length(name)-1)
	from country;  
-- k
select curdate() hoy, 
		adddate(curdate(),interval 1 day) mañana,
        subdate(curdate(),interval 1 day) ayer,
        subdate(curdate(),interval 1 year) hace1Año,
        adddate(curdate(),interval 1 month) dentro1Mes;    
-- l
set lc_time_names='es_ES';
select date_format('2000-01-02',
			concat_ws(' ',
			  'Yo nací el %W, "%d de %M de %Y. Hace',
			  datediff(curdate(),'2000-01-02') ,
			  'días')) as Texto;