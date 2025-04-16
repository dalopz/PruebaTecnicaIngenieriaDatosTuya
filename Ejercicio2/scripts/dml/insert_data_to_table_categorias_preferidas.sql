INSERT INTO categorias_preferidas (identificacion, nombre_cliente, categoria_preferida, ultima_transaccion)
SELECT 
    t.IDENTIFICACION,  
    c.nombre,  
    ccc.NOMBRE_CATEGORIA,  
    MAX(tx.fecha)
FROM 
    TRANSACCION t
JOIN 
    CLIENTES c ON t.IDENTIFICACION = c.identificacion  
JOIN 
    CATEGORIAS_CONSUMO ccc ON t.CODIGO_CATEGORIA = ccc.CODIGO_CATEGORIA  
JOIN 
    Tiempo tx ON t.id_fecha = tx.id 
JOIN 
    Tiempo tap ON c.fecha_apertura_id = tap.id  -- Fecha de apertura de la tarjeta
WHERE 
    t.ESTADO = 'Aprobada'
    AND tx.fecha >= tap.fecha  -- Validación de que la transacción ocurrió luego de la apertura
GROUP BY 
    t.IDENTIFICACION, ccc.NOMBRE_CATEGORIA
ORDER BY 
    t.IDENTIFICACION, COUNT(t.ID_TRANSACCION) DESC;
