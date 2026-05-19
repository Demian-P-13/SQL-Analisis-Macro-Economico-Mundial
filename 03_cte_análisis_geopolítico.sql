-- Proyecto: Análisis Macro-Económico Mundial
-- Objetivo: Determinar el idioma del "gigante" regional y de los paises que lo compartan en la región.
-- Autor: Demian Piña
-- 1.- Creamos un filtro que solo nos devuelva la lengua oficial del país dominante.

WITH idioma_gigante AS (
    SELECT v.Región, v.Pais, cl.Language 
    FROM v_analisis_macro v
    INNER JOIN countrylanguage cl ON v.Codigo = cl.CountryCode
    WHERE cl.IsOfficial = 'T' 
      AND v.PIB = (SELECT MAX(PIB) FROM v_analisis_macro v2 WHERE v2.Región = v.Región)
)

-- 2.- Creamos una tabla que compara los países miembros de cada región y compara si su lengua oficial es igual a la del país dominante. 
SELECT 
    ig.Región,
    ig.Pais AS Pais_Gigante,
    ig.Language AS Idioma_Comun,
    co.Name AS Pais_Socio
FROM country co
INNER JOIN countrylanguage cl ON co.Code = cl.CountryCode
INNER JOIN idioma_gigante ig ON cl.Language = ig.Language 
    AND co.Region = ig.Región -- Esto asegura que la influencia sea REGIONAL
WHERE co.Name <> ig.Pais -- Excluimos al gigante para ver solo a los socios
ORDER BY ig.Región, co.Name;