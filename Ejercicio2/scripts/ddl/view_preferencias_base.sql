CREATE OR REPLACE VIEW vista_preferencias_base AS
SELECT
    c.identificacion,
    c.nombre AS nombre_cliente,
    cg.NOMBRE_CATEGORIA AS nombre_categoria,  
    COUNT(t.ID_TRANSACCION) AS total_transacciones,
    MAX(fecha_tx.fecha) AS ultima_transaccion,
    RANK() OVER (
        PARTITION BY c.identificacion
        ORDER BY COUNT(t.ID_TRANSACCION) DESC
    ) AS nivel_preferencia
FROM TRANSACCION t
JOIN CLIENTES c ON t.IDENTIFICACION = c.identificacion
JOIN Tiempo fecha_tx ON t.id_fecha = fecha_tx.id
JOIN Tiempo fecha_apertura ON c.fecha_apertura_id = fecha_apertura.id
JOIN CATEGORIAS_CONSUMO cat ON t.CODIGO_CATEGORIA = cat.CODIGO_CATEGORIA
JOIN CATEGORIA_GENERAL cg ON cat.id_categoria_general = cg.id
WHERE
    t.ESTADO = 'Aprobada'
    AND fecha_tx.fecha >= fecha_apertura.fecha
GROUP BY
    c.identificacion,
    c.nombre,
    cg.NOMBRE_CATEGORIA;
