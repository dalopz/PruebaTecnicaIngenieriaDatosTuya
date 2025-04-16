# PruebaTecnicaIngenieriaDatosTuya


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

PS C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1> python main.py --input "test_file/" --output "outputs"
Archivo generado: outputs\prueba_base64.html
Archivo generado: outputs\prueba2_base64.html

Imágenes procesadas con éxito:
 - C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1\test_file\imagen.png
 - C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1\test_file\imagen2.png

Imágenes que fallaron:
PS C:\David Lopez Cuervo\PruebaTecnicaIngenieriaDatosTuya\Ejercicio1> 

# Para ejecutarlo 
Coloca tus archivos HTML dentro de la carpeta test_file/ o en su defecto dejar los archivos que ya se encuentran para la prueba
Los archivos HTML deben tener imágenes que desees convertir a Base64 

Navega al directorio donde está el archivo main.py.

Ejecuta el script principal con los siguientes parámetros:
python main.py --input "test_file/" --output "outputs" -- esto para recorrer todos los archivos





## Desarrollo del Ejercicio 2




## Desarrollo del Ejercicio 3