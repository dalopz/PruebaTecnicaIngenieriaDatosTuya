# PruebaTecnicaIngenieriaDatosTuya -  David López Cuervo


## Desarrollo del Ejercicio 1

Se implementó una solución en Python que permite procesar archivos HTML, encontrar las imagenes referenciadas mediante el tag `<img>` y reemplazar estas imagenes con sus representaciones en formato Base64.

### Estructura del Proyecto

El desarrollo del ejercicio 1 está compuesto por varias clases que se encargan de diferentes partes del procesamiento:

1. **`HTMLImageParser`**:
   Esta clase analiza los archivos HTML y extraer las rutas de las imagenes referenciadas mediante el tag `<img>`. Utiliza un enfoque basado en la librería `HTMLParser` para procesar el contenido del HTML y obtener todos los valores de los atributos `src` de las imagenes.

2. **`ImageBase64Converter`**:
   Esta clase se encarga de convertir las imagenes a formato Base64. Toma una ruta de archivo de imagen y la convierte en una cadena Base64, que luego puede ser utilizada para reemplazar la ruta original de la imagen en el archivo HTML.

3. **`HTMLProcessor`**:
   Esta es la clase principal que orquesta el procesamiento. Su objetivo es:
   - Recibir una lista de archivos HTML o directorios que contengan archivos HTML.
   - Para cada archivo HTML, extraer las rutas de las imagenes mediante `HTMLImageParser`.
   - Convertir cada imagen a Base64 utilizando `ImageBase64Converter`.
   - Reemplazar las rutas de las imagenes en el HTML con los datos codificados en Base64.
   - Guardar el archivo HTML resultante en una carpeta de salida específica.
   - Registrar los resultados del procesamiento, indicando qué imagenes se procesaron con éxito y cuáles fallaron.

### Flujo de procesamiento

El proceso de conversión se realiza de la siguiente manera:

1. **Recopilación de archivos HTML**: 
   La herramienta puede recibir ya sea una lista de archivos HTML específicos o una lista de directorios. Si se proporcionan directorios, el sistema recursivamente busca todos los archivos `.html` dentro de esos directorios, incluyendo subdirectorios.

2. **Procesamiento de cada archivo HTML**:
   Para cada archivo HTML, se extraen todas las imagenes referenciadas con el tag `<img>`. Las rutas de estas imagenes se obtienen del atributo `src` de cada etiqueta.

3. **Conversión de imagenes a Base64**:
   Cada imagen referenciada se intenta convertir a formato Base64. Si la imagen existe y puede ser convertida correctamente, su código Base64 reemplaza la ruta original de la imagen en el archivo HTML.

4. **Resultados**:
   Durante el proceso, se realiza un seguimiento de las imagenes que fueron procesadas correctamente y de aquellas que no pudieron ser convertidas. Los resultados se almacenan en un objeto con dos listas:
   - **`success`**: Contiene las rutas de las imagenes que fueron procesadas exitosamente.
   - **`fail`**: Contiene las rutas de las imagenes que no pudieron ser procesadas (por ejemplo, debido a que el archivo no fue encontrado o la conversión falló).

5. **Generación de archivos de salida**:
   Finalmente, el archivo HTML procesado con las imagenes en Base64 es guardado en una nueva ubicación dentro de la carpeta de salida especificada. El nombre del archivo resultante se genera a partir del nombre original, agregando el sufijo `_base64` para diferenciarlo del archivo original.

### Resultado Final

Al finalizar el procesamiento, el sistema retorna un resumen con los resultados de las imagenes procesadas. Se imprime una lista con las imagenes que se han convertido correctamente y una lista con las que no pudieron ser procesadas.
```bash
PS C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1> python main.py --input "test_file/" --output "outputs"
Archivo generado: outputs\prueba_base64.html
Archivo generado: outputs\prueba2_base64.html

Imágenes procesadas con éxito:
 - C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1\test_file\imagen.png
 - C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1\test_file\imagen2.png

Imágenes que fallaron:

PS C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1> 
```
### Para ejecutarlo 
Coloca tus archivos HTML dentro de la carpeta test_file/ o en su defecto dejar los archivos que ya se encuentran para la prueba
Los archivos HTML deben tener imágenes que desees convertir a Base64 

Navega al directorio donde está el archivo main.py.

Ejecuta el script principal con los siguientes parámetros:

python main.py --input "test_file/" --output "outputs"     esto para recorrer el directorio

python main.py test_file/prueba.html    esto para un archivo en especifico





## Desarrollo del Ejercicio 2


## Análisis y Limpieza de Datos

### CLIENTES

- Se detectaron **14 registros duplicados** en la columna `IDENTIFICACIÓN`, con clientes distintos compartiendo el mismo valor.
- Esto generaba problemas de integridad referencial, ya que no era posible determinar con certeza qué cliente había realizado cada transacción.

#### Opciones Consideradas

1. **Crear un nuevo ID concatenado** (ej. `IDENTIFICACIÓN` + `nombre` o `tipp  docuemnto` )  
   → Rechazado, ya que la hoja `TRANSACCIONES` no tenía suficiente información para replicar esta clave.

2. **Conservar registros activos y eliminar duplicados inactivos**  
   → Rechazado, ya que algunos clientes inactivos tenían transacciones válidas previas a la apertura de otro cliente duplicado.

3. **Filtrar por clientes con transacciones válidas (fecha transacción > apertura tarjeta)**  
   → Muy pocos cumplían con esta regla y no se garantizaba integridad al unir con `TRANSACCIONES`.

#### Solución Aplicada

Para continuar con el ejercicio, se eliminaron los duplicados conservando los registros **más recientes**, simulando una regla de negocio donde "el registro válido es el último".  
Esto generó el archivo `clientes_supuestos.csv` en `data/processed/`.

**Nota:** Esta solución fue tomada exclusivamente para fines de esta prueba.  
La **buena práctica** sería implementar un gobierno de datos y corregir estas inconsistencias en origen con las personas o area encargada.

---

##  Limpieza y Preparación de las Otras Tablas

### TRANSACCIONES

- Validación de fechas de transacción.
- Normalización de estados de tarjeta y tipos de tarjeta.
- Transformación de nombres de columnas.

### CATEGORIAS_CONSUMO

- Estandarización y separación por dimensiones: ciudad, departamento, categoría general.

### Dimensiones creadas

- `CLASIFICACIÓN`
- `TIPO_TARJETA`
- `ESTADO_TARJETA`
- `TIPO_DOCUMENTO`
- `CATEGORÍA_GENERAL`
- `CIUDAD`
- `DEPARTAMENTO`

- `TIEMPO`  
  Se creó para relacionar las fechas de transacción a través de índices, permitiendo mejores consultas y rendimiento en análisis temporal.

---

##  Creación de Base de Datos

- La base de datos `preferencia_consumo` se creó en MySQL.
- Las tablas fueron creadas y llenadas usando archivos `.csv` desde `data/processed/`, importados con **DBeaver**.
- El script para crear la estructura está en:

```bash
scripts/ddl/bd_preferencia_consumo.sql
```
## Vista de Preferencias de Consumo

Se construyó una vista llamada `vista_preferencias_base`, que tiene como objetivo proporcionar una base dinámica para el análisis de preferencias de consumo de los clientes. Esta vista permite identificar patrones y preferencias en las categorías de consumo a lo largo del tiempo.

### Descripción de la Vista

La vista `vista_preferencias_base` realiza las siguientes acciones:

1. **Unión entre tablas**:
   - `CLIENTES` y `TRANSACCIONES`: Para vincular los datos de los clientes con sus transacciones.
   - `TRANSACCIONES` y `CATEGORIAS_CONSUMO`: Para conectar las transacciones con las categorías generales de consumo asociadas.

2. **Cálculo de la cantidad total de transacciones por cliente y categoría**:
   - Para cada cliente, se calcula cuántas veces ha realizado una transacción en cada categoría general.

3. **Facilidad de filtrado dinámico**:
   - Se puede filtrar por niveles de preferencia de los clientes y por ventanas temporales.

### Beneficios de la Vista

- **Análisis por niveles de preferencia**: Permite conocer las categorías preferidas de los clientes según su volumen de transacciones.
- **Consultas dinámicas**: Se puede ajustar la vista para obtener diferentes resultados según los filtros aplicados (e.g., por fecha, categoría, etc.).
- **Facilidad para realizar un seguimiento de cambios**: Permite analizar cómo los hábitos de consumo de los clientes cambian con el tiempo.

### Script de la Vista

El script para crear la vista `vista_preferencias_base` está contenido en el archivo:

```bash
scripts/ddl/view_preferencia_base.sql
```
### Resultado de la ejecucion
```bash
mysql> SELECT * FROM vista_preferencias_base WHERE nivel_preferencia = 1;
+-------------------+------------------+------------------+---------------------+--------------------+-------------------+
| identificacion    | nombre_cliente   | nombre_categoria | total_transacciones | ultima_transaccion | nivel_preferencia |
+-------------------+------------------+------------------+---------------------+--------------------+-------------------+
| 2A3B4C5D6E7F8G9H0 | Laura L�pez      | Hogar            |                   1 | 2021-06-15         |                 1 |
| 2A3B4C5D6E7F8G9H0 | Laura L�pez      | Ropa             |                   1 | 2021-11-15         |                 1 |
| 2C3D4E5F6G7H8I9J0 | Juan P�rez       | Mascotas         |                   1 | 2023-02-10         |                 1 |
| 2G3H4I5J6K7L8M9N0 | Ana Mart�nez     | Belleza          |                   1 | 2020-11-05         |                 1 |
| 2I3J4K5L6M7N8O9P0 | Elena Ruiz       | Electr�nica      |                   1 | 2020-12-05         |                 1 |
| 2I3J4K5L6M7N8O9P0 | Elena Ruiz       | Ropa             |                   1 | 2020-09-10         |                 1 |
| 2K3L4M5N6O7P8Q9R0 | Pedro Gonz�lez   | Salud            |                   1 | 2021-09-15         |                 1 |
| 2K3L4M5N6O7P8Q9R0 | Pedro Gonz�lez   | Juguetes         |                   1 | 2021-07-05         |                 1 |
| 2K3L4M5N6O7P8Q9R0 | Pedro Gonz�lez   | Belleza          |                   1 | 2023-03-05         |                 1 |
| 2K3L4M5N6O7P8Q9R0 | Pedro Gonz�lez   | Ferreter�a       |                   1 | 2017-08-05         |                 1 |
| 2K3L4M5N6O7P8Q9R0 | Pedro Gonz�lez   | Mascotas         |                   1 | 2021-08-25         |                 1 |
| 2O3P4Q5R6S7T8U9V0 | Marta Torres     | Salud            |                   1 | 2020-12-05         |                 1 |
| 2O3P4Q5R6S7T8U9V0 | Marta Torres     | Muebles          |                   1 | 2023-06-01         |                 1 |
| 2Q3R4S5T6U7V8W9X0 | Luis Hern�ndez   | Jardiner�a       |                   1 | 2021-10-15         |                 1 |
| 2S3T4U5V6W7X8Y9Z0 | Andr�s Jim�nez   | Libros           |                   1 | 2014-08-25         |                 1 | 
| 2S3T4U5V6W7X8Y9Z0 | Andr�s Jim�nez   | Automotriz       |                   1 | 2017-09-05         |                 1 | 
| 2W3X4Y5Z6A7B8C9D0 | Carlos Rodr�guez | Viajes           |                   1 | 2023-01-20         |                 1 | 
| 2Y3Z4A5B6C7D8E9F0 | Jorge Flores     | Joyer�a          |                   1 | 2018-12-10         |                 1 | 
| 2Y3Z4A5B6C7D8E9F0 | Jorge Flores     | Viajes           |                   1 | 2023-05-01         |                 1 | 
+-------------------+------------------+------------------+---------------------+--------------------+-------------------+ 
21 rows in set (0.03 sec)
```

## Desarrollo del Ejercicio 3

### 1. Análisis exploratorio

Se realizó una revisión de las hojas `historia` y `retiros` del archivo `rachas.xlsx` para validar:
- Formato correcto de fechas.
- Ausencia de valores atípicos o inconsistencias en los saldos.
- Completitud de los identificadores de clientes.

### 2. Normalización con Dimensión Tiempo

Para estructurar una base de datos más **normalizada** y facilitar las uniones, se creó una tabla de dimensión `TIEMPO`, que contiene todas las fechas únicas de los cortes de mes. Esto permite:
- Eliminar duplicidad de valores de fecha en las tablas principales.
- Mejorar la eficiencia de las consultas y joins.
- Simplificar comparaciones y filtros entre fechas (usando `id_fecha` en lugar de valores DATE).

Las columnas `corte_mes` (en `historia`) y `fecha_retiro` (en `retiros`) se reemplazaron por el correspondiente `id` de la tabla `TIEMPO`. Los datos resultantes fueron exportados como CSV a `data/processed`.

La data original se conservó en `data/raw` para garantizar trazabilidad y control de versiones.

### 3. Carga de la base de datos

Se implementó un entorno de base de datos usando Docker y la imagen oficial de MySQL. El script de creación de esquema y tablas se encuentra en:

```
scripts/ddl/bd_rachas.sql
```

La carga de datos se realizó desde los archivos CSV procesados utilizando DBeaver.


## Procedimiento almacenado `obtener_rachas`

Este procedimiento resuelve el problema con base en una fecha de corte (`fecha_base`) y una duración mínima (`n_min_racha`) y sigue los siguientes pasos:

### 1. Generación de combinaciones cliente-fecha
Se obtiene el producto cartesiano de todos los clientes activos con todas las fechas menores o iguales a `fecha_base`, permitiendo reconstruir una serie mensual completa incluso si hay meses faltantes.

### 2. Clasificación de saldos por nivel
Se clasifica cada saldo según los siguientes rangos:
- `N0`: 0 ≤ saldo < 300,000
- `N1`: 300,000 ≤ saldo < 1,000,000
- `N2`: 1,000,000 ≤ saldo < 3,000,000
- `N3`: 3,000,000 ≤ saldo < 5,000,000
- `N4`: saldo ≥ 5,000,000

Cuando no hay dato de saldo para una fecha específica despues de la primera aparición del cliente y que este no este retirado, se asume nivel `N0`, **excepto si la fecha es posterior a la fecha de retiro del cliente**, en cuyo caso no se incluye.

### 3. Detección de rachas

Se calcula un número de grupo utilizando diferencias de `ROW_NUMBER` para identificar **subseries consecutivas** con el mismo nivel. Luego se agrupan esas series para contar la longitud de cada racha.

### 4. Filtro y priorización

Se filtran solo aquellas rachas cuya duración es mayor o igual a `n_min_racha`. Si un cliente tiene varias, se selecciona:
- La racha más larga.
- En caso de empate, la más reciente (menor o igual a `fecha_base`).

### 5. Resultado final

El procedimiento retorna una tabla con las siguientes columnas:
- `identificacion`
- `nivel` (N0-N4)
- `racha` (cantidad de meses consecutivos)
- `fecha_fin` (fecha de corte de fin de la racha)


## Ejecución

## 1. Crear la base de datos y las tablas en mysql

1. Abre el archivo `scripts/ddl/bd_rachas.sql`.
2. Ejecuta el script en tu cliente MySQL para crear el esquema y las tablas necesarias:
   - `TIEMPO`
   - `HISTORIA`
   - `RETIRO`

---

## 2. Cargar los datos procesados

Usando una herramienta como **DBeaver** que fue la usada:

1. Haz clic derecho sobre cada tabla → **"Import Data"**.
2. Importa los archivos `.csv` desde la carpeta `data/processed/`:
   - `TIEMPO.csv` → tabla `TIEMPO`
   - `HISTORIA.csv` → tabla `HISTORIA`
   - `RETIRO.csv` → tabla `RETIRO`
3. Asegúrate de mapear correctamente las columnas según el orden de cada tabla.
4. Ejecuta la importación y verifica que los datos hayan quedado correctamente cargados.

---

## 3. Crear el procedimiento almacenado

1. Abre el archivo `stored_procedures/obtener_rachas.sql`.
2. Ejecuta el contenido del script en tu base de datos para crear el procedimiento `obtener_rachas`.

---

## 4. Ejecutar el procedimiento

Llama al procedimiento para obtener los resultados. Por ejemplo:

```sql
CALL obtener_rachas('2023-03-31', 3);


## Resultado de la ejecución

Database changed
mysql> CALL obtener_rachas('2023-03-31', 3);
+-------------------+-------+-------+------------+
| identificacion    | nivel | racha | fecha_fin  |
+-------------------+-------+-------+------------+
| 5CS7MKN5CCCZTYEH8 | N3    |     3 | 2023-03-31 |
| DJXLPRMY5ZZMANLU6 | N4    |     3 | 2023-03-31 |
| K2DBNBQ09G1QCCD7W | N3    |     3 | 2023-03-31 |
| KUD4O3VLEGN7O0D3B | N2    |     3 | 2023-03-31 |
| LATSV8PKLN0G0XSCQ | N3    |     3 | 2023-03-31 |
| MUIZHHC8NUPU3856X | N3    |     3 | 2023-03-31 |
| R7Q4Z9AULIORDJQ9D | N2    |     3 | 2023-03-31 |
| V4LNPTIOKCV53PIHE | N3    |     3 | 2023-03-31 |
+-------------------+-------+-------+------------+
8 rows in set (0.06 sec)

Query OK, 0 rows affected (0.06 sec)

