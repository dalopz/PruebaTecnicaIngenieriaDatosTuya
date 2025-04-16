-- 1. Clientes únicos
DROP TEMPORARY TABLE IF EXISTS tmp_clientes;
CREATE TEMPORARY TABLE tmp_clientes AS
SELECT DISTINCT identificacion FROM HISTORIA;

SELECT * FROM tmp_clientes;

-- 2. Fechas válidas hasta la fecha_base
DROP TEMPORARY TABLE IF EXISTS tmp_fechas_validas;
CREATE TEMPORARY TABLE tmp_fechas_validas AS
SELECT id AS id_fecha, fecha
FROM TIEMPO
WHERE fecha <= '2023-03-31';

SELECT * FROM tmp_fechas_validas;



-- 3. Producto cartesiano cliente x fecha
DROP TEMPORARY TABLE IF EXISTS tmp_cliente_fechas;
CREATE TEMPORARY TABLE tmp_cliente_fechas AS
SELECT c.identificacion, f.id_fecha, f.fecha
FROM tmp_clientes c
CROSS JOIN tmp_fechas_validas f;

SELECT * FROM tmp_cliente_fechas
ORDER BY identificacion, fecha;

-- 4. Clasificación de saldos por nivel
DROP TEMPORARY TABLE IF EXISTS tmp_saldos_nivel;
CREATE TEMPORARY TABLE tmp_saldos_nivel AS
SELECT 
    identificacion,
    id_fecha,
    CASE
        WHEN saldo >= 0       AND saldo < 300000    THEN 'N0'
        WHEN saldo >= 300000  AND saldo < 1000000   THEN 'N1'
        WHEN saldo >= 1000000 AND saldo < 3000000   THEN 'N2'
        WHEN saldo >= 3000000 AND saldo < 5000000   THEN 'N3'
        WHEN saldo >= 5000000                       THEN 'N4'
    END AS nivel
FROM HISTORIA;

SELECT * FROM tmp_saldos_nivel;


-- 5. Fechas de retiro
DROP TEMPORARY TABLE IF EXISTS tmp_retiros;
CREATE TEMPORARY TABLE tmp_retiros AS
SELECT identificacion, id_fecha AS id_retiro FROM RETIRO;

SELECT * FROM tmp_retiros;


-- 6. Tabla final con niveles asignados
DROP TEMPORARY TABLE IF EXISTS tmp_cliente_niveles;
CREATE TEMPORARY TABLE tmp_cliente_niveles AS
SELECT 
    cf.identificacion,
    cf.id_fecha,
    COALESCE(sn.nivel, 'N0') AS nivel,
    r.id_retiro
FROM tmp_cliente_fechas cf
LEFT JOIN tmp_saldos_nivel sn 
    ON sn.identificacion = cf.identificacion AND sn.id_fecha = cf.id_fecha
LEFT JOIN tmp_retiros r 
    ON cf.identificacion = r.identificacion
WHERE r.id_retiro IS NULL OR cf.id_fecha <= r.id_retiro;

SELECT * FROM tmp_cliente_niveles
ORDER BY identificacion, id_fecha;


-- 7. Agrupación por racha
DROP TEMPORARY TABLE IF EXISTS tmp_numerada;
CREATE TEMPORARY TABLE tmp_numerada AS
SELECT 
    t.*,
    ROW_NUMBER() OVER (PARTITION BY identificacion ORDER BY id_fecha) -
    ROW_NUMBER() OVER (PARTITION BY identificacion, nivel ORDER BY id_fecha) AS grupo
FROM tmp_cliente_niveles t;

SELECT * FROM tmp_numerada
ORDER BY identificacion, id_fecha;


-- 8. Rachas por grupo
DROP TEMPORARY TABLE IF EXISTS tmp_rachas;
CREATE TEMPORARY TABLE tmp_rachas AS
SELECT 
    identificacion,
    nivel,
    COUNT(*) AS racha,
    MAX(id_fecha) AS id_fecha_fin
FROM tmp_numerada
GROUP BY identificacion, nivel, grupo;

SELECT * FROM tmp_rachas;


-- 9. Filtro de rachas por mínimo
DROP TEMPORARY TABLE IF EXISTS tmp_rachas_filtradas;
CREATE TEMPORARY TABLE tmp_rachas_filtradas AS
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY identificacion 
        ORDER BY racha DESC, id_fecha_fin DESC
    ) AS rn
FROM tmp_rachas
WHERE racha >= 3;

SELECT * FROM tmp_rachas_filtradas;


-- 10. Resultado final
SELECT 
    rf.identificacion,
    rf.nivel,
    rf.racha,
    t.fecha AS fecha_fin
FROM tmp_rachas_filtradas rf
JOIN TIEMPO t ON rf.id_fecha_fin = t.id
WHERE rf.rn = 1
ORDER BY identificacion;

