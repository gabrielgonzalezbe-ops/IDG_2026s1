SELECT *
FROM output.tot_profesionales


SELECT t.geocodigo::double precision, -- obs: acá el dato es texto, pero en dpa es numérico
		v.geom,
		t.nom_comuna,
		t.profesionales,
		t."tasa%"
		
FROM output.tot_profesionales AS t
JOIN dpa.zonas_censales_v AS v
ON t.geocodigo::double precision = v.geocodigo




CREATE TABLE output.tot_prof_geom AS
SELECT t.geocodigo::double precision,
		v.geom,
		t.nom_comuna,
		t.profesionales,
		t."tasa%"
		
FROM output.tot_profesionales AS t
JOIN dpa.zonas_censales_v AS v
ON t.geocodigo::double precision = v.geocodigo







-- PARA SABER EN QUÉ SISTEMA DE COORDENAS ESTÁ LO CREADO
SELECT ST_STRID(geom)
FROM tot_prof_geom






-- PORCENTAJE DE VIVIENDAS HACINADAS POR ZONA CENSAL
SELECT *
FROM "variables_codificacion" -- ind_hacin_rec


CREATE TABLE output.viv_hacinadas AS
SELECT c.nom_comuna, z.geocodigo, COUNT(*) AS hacinamiento

FROM public.viviendas AS v
JOIN public.zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN public.comunas AS c
ON z.codigo_comuna = c.codigo_comuna

GROUP BY z.geocodigo, c.nom_comuna
