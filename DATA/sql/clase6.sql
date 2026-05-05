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