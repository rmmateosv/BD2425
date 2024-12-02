use biblioteca;
-- ¿Qué índices tiene definidos la tabla salas?
-- Solamente un ínidice para el campo id que es PK

-- Muestra qué índices se usan si recupero la sala con id 1
explain select * from salas where id = 1;

-- Muestra qué índices se usan si recupero 
-- las salas de la planta 1
explain select * from salas where planta = 1;
-- Vemos que no se ha seleccionado ningún índice
-- Esto es porque el campo planta no es ni PK,FK, UQ

-- Crea un índice por el campo planta
create index iPlanta on salas(planta);
-- comprueba si ahora se usa este índice en la consulta
-- anterior
explain select * from salas where planta = 1;

-- Crea un ínidce compuesto por planta y por sala
create index iPlantaSala on salas(planta,sala);
-- Comprueba si selecciona el índice si accedo solamente 
-- por planta
explain select * from salas where planta = 1;
-- Ahora puede utilizar los dos índices que existen
-- Selecciona de forma automática el ídice compuesto

-- Comprueba si selecciona el índice si accedo solamente
-- por sala (salas que empiecen por c)
explain select * from salas where sala like 'c%';
-- Ha cogido el 2º???

-- Comprueba si selecciona índice si accedo por los campos
explain select * from salas where sala like 'c%' and planta=2;
-- También utiliza el segundo índice

-- Borra los dos índices creados
drop index iPlanta on salas; 
drop index iPlantaSala on salas; 

-- Crea un índice compuesto para los campos sala y planta
create index iSalaPlanta on salas(sala,planta);

-- Comprueba si se usa el índice si se accede solamente
-- por planta
explain select * from salas where planta = 1; 
-- ??