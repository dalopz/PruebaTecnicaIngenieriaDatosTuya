CREATE DATABASE db_preferencia_consumo;

USE db_preferencia_consumo;



CREATE TABLE TIPO_DOCUMENTO (
    id INT PRIMARY KEY,
    tipo_documento VARCHAR(50) NOT NULL 
);

-- Despues de cargar los datos, que el id sea incremental
ALTER TABLE TIPO_DOCUMENTO 
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;



CREATE TABLE TIPO_TARJETA (
    id INT PRIMARY KEY,
    tipo_tarjeta VARCHAR(20) NOT NULL
);

-- Despues de cargar los datos, que el id sea incremental
ALTER TABLE TIPO_TARJETA 
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;



CREATE TABLE CLASIFICACION (
    id INT PRIMARY KEY,
    clasificacion VARCHAR(50) NOT NULL
);

-- Despues de cargar los datos, que el id sea incremental
ALTER TABLE CLASIFICACION 
MODIFY COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
