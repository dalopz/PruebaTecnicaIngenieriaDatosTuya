CREATE TABLE categorias_preferidas (
    identificacion VARCHAR(50),
    nombre_cliente VARCHAR(100),
    categoria_preferida VARCHAR(100),
    ultima_transaccion DATE,
    PRIMARY KEY (identificacion, categoria_preferida)
);
