SELECT *
FROM "personas"
ORDER BY "persona_ref_id" ASC

SELECT *
FROM "variables"

SELECT *
FROM "variables_codificacion"



-- TOTAL PERSONAS POR COMUNA

SELECT c.nom_comuna, COUNT(*)
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY c.nom_comuna

-- TOTAL PERSONAS POR ZONA CENSAL
SELECT c.nom_comuna, z.geocodigo, COUNT(*)
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna





-- POBLACIÓN MENOR DE EDAD POR COMUNA
SELECT c.nom_comuna, COUNT(*) FILTER(WHERE p.p09 < 18) AS total_menores
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY c.nom_comuna


-- TASA DE MENORES DE EDAD POR COMUNA
SELECT c.nom_comuna, COUNT(*) AS "total personas", COUNT(*) FILTER(WHERE p.p09 < 18) AS "total menores", 
(((COUNT(*) FILTER(WHERE p.p09 < 18))*100)/COUNT(*)) AS "tasa de menores"
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY c.nom_comuna
ORDER BY "tasa de menores"





-- TASA DE MENORES DE EDAD POR COMUNA CON DECIMALES
SELECT c.nom_comuna, COUNT(*) AS "total personas", COUNT(*) FILTER(WHERE p.p09 < 18) AS "total menores", 
ROUND(((COUNT(*) FILTER(WHERE p.p09 < 18))*100.0)/COUNT(*),2) AS tasa_de_menores -- se detalla n° de decimales
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY c.nom_comuna
ORDER BY tasa_de_menores


-- TOTAL DE PROFESIONALES POR ZONA CENSAL, ORDENADOS DE MAYOR A MENOR
SELECT c.nom_comuna, z.geocodigo, 
COUNT(*) FILTER(WHERE p.p15 >= 12 and p.p15 <=14)
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna



-- TOTAL DE PROFESIONALES POR ZONA CENSAL, ORDENADOS DE MAYOR A MENOR
SELECT c.nom_comuna, z.geocodigo, COUNT(*) FILTER(WHERE p.p15 >= 12 and p.p15 <=14) AS profesionales,
ROUND((COUNT(*) FILTER(WHERE p.p15 >= 12 and p.p15 <=14)*100.0/COUNT(*)), 2) AS "tasa%"
FROM public.personas AS p
JOIN public.hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id
JOIN public.viviendas AS v
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY nom_comuna, "tasa%"
