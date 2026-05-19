-- PROYECTO: Análisis de dominancia económica
-- Objetivo: Crear una capa de datos limpia con métricas de productividad.
-- Autor: Demian Piña

-- 1.- Crear y nombrar la vista.
CREATE VIEW `v_analisis_macro` AS 

-- 2.Seleccionar las variables de interés.
select 
`country`.`Name` AS `Pais`,
`country`.`Code` AS `Codigo`,
`country`.`Region` AS `Región`,
`country`.`GNP` AS `PIB`,
`country`.`Population` AS `Población`,
`country`.`SurfaceArea` AS `Superficie`,
round(`country`.`GNP` / `country`.`Population`,4) AS `GNP per cápita`,
round(`country`.`GNP` / `country`.`SurfaceArea` * 100,2) AS `Densidad de riqueza` 
-- 3.- En este caso solo trabajaremos con la tabla country.
from `country` 
-- 4.-Establecemos un filtro para sacar a paises que puedan generar ruido en el análisis. 
where `country`.`GNP` > 0 and `country`.`Population` > 1000