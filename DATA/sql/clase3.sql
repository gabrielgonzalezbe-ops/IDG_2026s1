/*

esto es un comentario largo

*/

-- esto es un comentario corto

SELECT * -- Nombre de las columnas. "*" es para llamar todas las columnas
FROM "Artist"; -- Nombre de la tabla

-- Seleccionar nombre y apellido de los clientes
SELECT "FirstName", "LastName"
FROM "Customer"

-- Seleccionar todos los clientes de Canadá
SELECT *
FROM "Customer"
WHERE "Country" = 'Canada' -- filtro

-- Ordenar por orden alfabetico los clientes canadienses según su apellido
SELECT *
FROM "Customer"
WHERE "Country" = 'Canada' -- filtro
ORDER BY "LastName"

-- Ordenar por orden alfabetico DESCENDENTE los clientes canadienses según su apellido
SELECT *
FROM "Customer"
WHERE "Country" = 'Canada' -- filtro
ORDER BY "LastName" DESC -- tambiénm puede ser ASC



-- generar consulta que seleccione todos los empleados que trabajen como 'it staff', 
-- ordenados por su primer nombre

SELECT *
FROM "Employee"
WHERE "Title" = 'IT Staff'
ORDER BY "FirstName"

-- generar consulta que mantenga únicamente el nombre de la canción y su duración,
-- ordenados según duración

SELECT "Name", "Milliseconds"
FROM "Track"
ORDER BY "Milliseconds"




-- Renombrar columnas
SELECT "FirstName" AS "Nombre", "LastName" AS "Apellido"
FROM "Customer"
-- que es lo mismo que lo siguiente:
SELECT "FirstName" "Nombre", "LastName" "Apellido"
FROM "Customer"
-- dado que al no existir el AS, se reconoce que ahí va uno



-- CONTAR TOTAL DE CLIENTES
SELECT COUNT (*)
FROM "Customer"


-- renombrar lo anterioi
-- CONTAR TOTAL DE CLIENTES
SELECT COUNT (*) AS "Total Clientes"
FROM "Customer"





-- para que se muestre o no una columna, todo cambio debe ir en la parte del SELECT
-- SELECCIONAR NÚMERO DE CLIENTES POR PAÍS
SELECT "Country" AS "País", COUNT (*) AS "Total Clientes"
FROM "Customer"
GROUP BY "Country"
ORDER BY "Total Clientes" DESC
LIMIT 5 -- esto es para mostrar tantos registros como se necesiten




-- SELECCIONAR TOP 5 DE PAÍSES CON MÁS VENTAS
-- PISTA: USAR SUM()
SELECT SUM ("Total") -- esto es para sumar todas las ventas
FROM "Invoice"

SELECT "BillingCountry" AS "PAÍS", SUM ("Total") AS "Ventas"
FROM "Invoice"
GROUP BY "BillingCountry"
ORDER BY "BillingCountry" DESC



-- seleccionar albumes y sus artistas
SELECT "Album"."Title" AS "Album", "Artist"."Name" AS "Artist"
FROM "Artist" -- Tabla 1 de mi consulta
JOIN "Album"  -- Tabla 2 de mi consulta 
ON "Artist"."ArtistId" = "Album"."ArtistId"



-- lo anterior pero con buenas prácticas
-- seleccionar albumes y sus artistas
SELECT al."Title" AS "Album", ar."Name" AS "Artist"
FROM "Artist" AS ar -- acá se renombra y se acotan, luego se cambian en las otras partes
JOIN "Album" AS al
ON ar."ArtistId" = al."ArtistId"





-- MOSTRAR NOMBRE DE LA PISTA, NOMBRE DEL ÁLBUM Y NOMBRE DEL ARTISTA.
-- ORDENAR ALFABÉTICAMENTE POR ARTISTA
SELECT  ar."Name" AS "Artista", al."Title" AS "Album", tr."Name" AS "Pista"
FROM "Artist" AS ar
JOIN "Album"  AS al
ON ar."ArtistId" = al."ArtistId"
JOIN "Track" AS tr
ON al."AlbumId" = tr."AlbumId"
ORDER BY ar





-- GENERAR TABLA DE TOTAL DE VENTAS POR PAÍS
SELECT "BillingCountry" AS "país", SUM ("Total") AS "ventas"
FROM "Invoice"
GROUP BY "BillingCountry"

-- PARA VER LAS BOLETAS MAYORES A 5 Y MENORES A 10
SELECT *
FROM "Invoice"
WHERE ("Total" > 5) AND ("Total" < 10)
ORDER BY "Total"

-- PARA FILTRAR LOS PAÍSES CON VENTAS MAYORES A 100
SELECT "BillingCountry" AS "país", SUM ("Total") AS "ventas"
FROM "Invoice"
GROUP BY "BillingCountry"
HAVING (SUM ("Total") > 100)




-- ENCONTRAR EL TOTAL DE PISTAS Y LA DURACIÓN PROMEDIO DE LAS PISTAS DE CADA GÉNERO
SELECT *
FROM "Genre"

SELECT "Name", COUNT ("GenreId")
FROM "Track"
GROUP BY "GenreId"


SELECT tr."GenreId", gn."Name", COUNT (tr."Name") AS "N° de pistas", SUM (tr."Milliseconds") AS "Duración Total", AVG() 
FROM "Track" AS tr
JOIN "Genre" AS gn
ON tr."GenreId" = gn."GenreId"
GROUP BY gn."Name", tr."GenreId"
ORDER BY "GenreId"
