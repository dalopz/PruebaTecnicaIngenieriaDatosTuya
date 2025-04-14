LOAD DATA INFILE 'C:/Ejercicio2/data/processed/tipo_documento.csv'
INTO TABLE TIPO_DOCUMENTO
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, tipo_documento);
