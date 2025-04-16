-- Insertar datos en categorias_preferidas
INSERT INTO categorias_preferidas (identificacion, nombre_cliente, categoria_preferida, ultima_transaccion)
SELECT 
    t.IDENTIFICACION,  -- Identificación del cliente
    c.nombre,  -- Nombre del cliente
    ccc.NOMBRE_CATEGORIA,  -- Nombre de la categoría preferida
    MAX(tx.fecha)  -- Fecha de la última transacción en esa categoría
FROM 
    TRANSACCION t
JOIN 
    CLIENTES c ON t.IDENTIFICACION = c.identificacion  
JOIN 
    CATEGORIAS_CONSUMO ccc ON t.CODIGO_CATEGORIA = ccc.CODIGO_CATEGORIA  
JOIN 
    Tiempo tx ON t.id_fecha = tx.id 
WHERE 
    t.ESTADO = 'Aprobada'  
GROUP BY 
    t.IDENTIFICACION, ccc.NOMBRE_CATEGORIA
ORDER BY 
    t.IDENTIFICACION, COUNT(t.ID_TRANSACCION) DESC;
