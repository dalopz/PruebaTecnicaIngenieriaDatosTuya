CREATE DATABASE bd_preferencia_consumo;

USE bd_preferencia_consumo;



-- Crear tabla TIPO_DOCUMENTO
CREATE TABLE TIPO_DOCUMENTO (
    id INT  PRIMARY KEY,
    tipo_documento VARCHAR(50) NOT NULL
);

-- Crear tabla CLASIFICACION
CREATE TABLE CLASIFICACION (
    id INT  PRIMARY KEY,
    clasificacion VARCHAR(50) NOT NULL
);

-- Crear tabla TIPO_TARJETA
CREATE TABLE TIPO_TARJETA (
    id INT PRIMARY KEY,
    tipo_tarjeta VARCHAR(50) NOT NULL
);

-- Crear tabla ESTADO_TARJETA
CREATE TABLE ESTADO_TARJETA (
    id INT PRIMARY KEY,
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
    nombre VARCHAR(100) NOT NULL,
    identificacion VARCHAR(50) NOT NULL,
    tipo_documento_id INT,
    clasificacion_id INT,
    tipo_tarjeta_id INT,
    fecha_apertura_id INT, 
    estado_tarjeta_id INT,
    PRIMARY KEY (identificacion),
    FOREIGN KEY (tipo_documento_id) REFERENCES TIPO_DOCUMENTO(id),
    FOREIGN KEY (clasificacion_id) REFERENCES CLASIFICACION(id),
    FOREIGN KEY (tipo_tarjeta_id) REFERENCES TIPO_TARJETA(id),
    FOREIGN KEY (estado_tarjeta_id) REFERENCES ESTADO_TARJETA(id),
    FOREIGN KEY (fecha_apertura_id) REFERENCES Tiempo(id)
);



-- Tablas para CATEGORIAS CONSUMO

-- Crear tabla CIUDAD
CREATE TABLE CIUDAD (
    id INT PRIMARY KEY,
    ciudad VARCHAR(100)
);

-- Crear tabla DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    id INT PRIMARY KEY,
    departamento VARCHAR(100)
);


CREATE TABLE CATEGORIA_GENERAL (
    id INT PRIMARY KEY,
    NOMBRE_CATEGORIA VARCHAR(100) NOT NULL
);


CREATE TABLE CATEGORIAS_CONSUMO (
    CODIGO_CATEGORIA INT PRIMARY KEY,
    id_categoria_general INT,
    id_ciudad INT,
    id_departamento INT,
    FOREIGN KEY (id_categoria_general) REFERENCES CATEGORIA_GENERAL(id),
    FOREIGN KEY (id_ciudad) REFERENCES CIUDAD(id),
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id)
);


-- Craer tabla TRANSACCION
CREATE TABLE TRANSACCION (
    ID_TRANSACCION INT PRIMARY KEY,
    IDENTIFICACION VARCHAR(50),
    CODIGO_CATEGORIA INT,
    ESTADO VARCHAR(20),
    VALOR_COMPRA DECIMAL(10,2),
    id_fecha INT,
    FOREIGN KEY (IDENTIFICACION) REFERENCES CLIENTES(identificacion),
    FOREIGN KEY (id_fecha) REFERENCES Tiempo(id)
);
