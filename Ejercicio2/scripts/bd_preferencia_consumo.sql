CREATE DATABASE bd_preferencia_consumo;

USE bd_preferencia_consumo;



-- Crear tabla TIPO_DOCUMENTO
CREATE TABLE TIPO_DOCUMENTO (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento VARCHAR(50) NOT NULL
);

-- Crear tabla CLASIFICACION
CREATE TABLE CLASIFICACION (
    id INT AUTO_INCREMENT PRIMARY KEY,
    clasificacion VARCHAR(50) NOT NULL
);

-- Crear tabla TIPO_TARJETA
CREATE TABLE TIPO_TARJETA (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_tarjeta VARCHAR(50) NOT NULL
);

-- Crear tabla ESTADO_TARJETA
CREATE TABLE ESTADO_TARJETA (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estado_tarjeta VARCHAR(50) NOT NULL
);


CREATE TABLE Tiempo (
    id INT PRIMARY KEY,
    fecha DATE,
    anio INT,
    mes INT,
    dia INT,
    nombre_mes VARCHAR(20),
    dia_semana VARCHAR(20),
    anio_mes CHAR(7),  
    semana_anio INT
);


-- Crear tabla CLIENTES
CREATE TABLE CLIENTES (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    identificacion VARCHAR(50) NOT NULL,
    tipo_documento_id INT,
    clasificacion_id INT,
    tipo_tarjeta_id INT,
    fecha_apertura_tarjeta DATE,
    estado_tarjeta_id INT,
    FOREIGN KEY (tipo_documento_id) REFERENCES TIPO_DOCUMENTO(id),
    FOREIGN KEY (clasificacion_id) REFERENCES CLASIFICACION(id),
    FOREIGN KEY (tipo_tarjeta_id) REFERENCES TIPO_TARJETA(id),
    FOREIGN KEY (estado_tarjeta_id) REFERENCES ESTADO_TARJETA(id)
);
