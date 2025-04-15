create database bd_rachas;

use bd_rachas

-- Craer tabla TIEMPO
CREATE TABLE TIEMPO (
    fecha DATE,
    id INT PRIMARY KEY, 
    anio INT,
    mes INT,
    dia INT,
    nombre_mes VARCHAR(20),
    dia_semana VARCHAR(15),
    anio_mes VARCHAR(7),
    semana_anio INT
);


-- Craer tabla RETIRO
CREATE TABLE RETIRO (
    identificacion VARCHAR(30),
    id_fecha INT,
    FOREIGN KEY (id_fecha) REFERENCES TIEMPO(id)
);

-- Crear tabla Historia
CREATE TABLE HISTORIA (
    identificacion VARCHAR(30),
    saldo BIGINT,
    id_fecha INT,
    FOREIGN KEY (id_fecha) REFERENCES TIEMPO(id)
);
