-- Proyecto: Análisis Macro-Económico Mundial
-- Objetivo: Determinar al país dominante de cada región comparando el PIB de cada país aportado al total regional.
-- autor: Demian Piña

CREATE PROCEDURE `sp_analisis_dominancia`(IN region_busqueda VARCHAR(50))
BEGIN
    -- 1. Declaramos la variable local para el total regional

    DECLARE total_regional DOUBLE;

    -- 2. Calculamos el total de la región seleccionada usando tu Vista

    SET total_regional = (SELECT SUM(PIB) FROM v_analisis_macro WHERE Región = region_busqueda);

    -- 3. Validación: ¿La región existe y tiene datos?

    IF total_regional IS NULL OR total_regional = 0 THEN
        SELECT 'Error: La región no existe o no tiene datos económicos' AS Mensaje;
    ELSE
        -- 4. Ejecutamos el ranking con el denominador regional

        SELECT 
            Pais, 
            PIB,
            ROUND((PIB / total_regional) * 100, 2) AS Porcentaje_Regional,
            CASE 
                WHEN (PIB / total_regional) * 100 > 30 THEN 'GIGANTE'
                ELSE 'Socio'
            END AS Estatus_Dominancia
        FROM v_analisis_macro
        WHERE Región = region_busqueda
        ORDER BY Porcentaje_Regional DESC;
    END IF;
END