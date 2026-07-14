SELECT *
FROM variables_codificacion


SELECT *
FROM "viviendas"

-- TOTAL viviendas POR COMUNA

SELECT c.nom_comuna, COUNT(*)
FROM public.viviendas AS v
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY c.nom_comuna


-- TOTAL viviendas POR ZONA CENSAL
SELECT c.nom_comuna, z.geocodigo, COUNT(*)
FROM public.viviendas AS v
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY c.nom_comuna


-- TOTAL DE techos débiles POR ZONA CENSAL, ORDENADOS DE MAYOR A MENOR
SELECT c.nom_comuna, z.geocodigo, 
COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6)
FROM public.viviendas AS v
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY c.nom_comuna




-- TASA DE techos precarios POR zona censal CON DECIMALES
SELECT c.nom_comuna, COUNT(*) AS "total viviendas", COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6) AS "techos precarios", 
ROUND(((COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6))*100.0)/COUNT(*),2) AS tasa_de_techos_precarios
FROM public.viviendas AS v
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY c.nom_comuna




-- TASA DE techos precarios Y migrantes POR zona censal CON DECIMALES
SELECT c.nom_comuna, COUNT(*) AS "total viviendas", COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6) AS "techos precarios", 
ROUND(((COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6))*100.0)/COUNT(*),2) AS "tasa de techos precarios", 
ROUND((COUNT(*) FILTER(WHERE p.p12pais >998)*100.0/COUNT(*)), 2) AS "porcentaje de migrantes"
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
JOIN public.provincias AS pr 
ON pr.provincia_ref_id = c.provincia_ref_id
WHERE pr.nom_provincia = 'VALPARAÍSO'
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY nom_comuna, "porcentaje de migrantes"


WITH agg AS
(SELECT c.nom_comuna, z.geocodigo::double precision AS geocodigo, COUNT(*) AS "total viviendas", COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6) AS "techos precarios", 
ROUND(((COUNT(*) FILTER(WHERE v.p03b >= 3 and v.p03b <=6))*100.0)/COUNT(*),2) AS "tasa de techos precarios", 
ROUND((COUNT(*) FILTER(WHERE p.p12pais >998)*100.0/COUNT(*)), 2) AS "porcentaje de migrantes"
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
JOIN public.provincias AS pr 
ON pr.provincia_ref_id = c.provincia_ref_id
WHERE pr.nom_provincia = 'VALPARAÍSO' AND c.nom_comuna != 'JUAN FERNÁNDEZ'
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY geocodigo, "porcentaje de migrantes"
)

SELECT g.*, shp.geom
FROM agg AS g
JOIN dpa.zonas_censales_v AS shp ON shp.geocodigo = g.geocodigo
WHERE g.geocodigo != '5101242001';