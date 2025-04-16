import sys
from pathlib import Path

# Agrega el directorio raíz del proyecto al sys.path
project_root = Path(__file__).resolve().parent
sys.path.insert(0, str(project_root))

# Ahora importa el módulo
from html_img_base64.processor import HTMLProcessor


def main():
    # Definir las rutas de los archivos o directorios que deseas procesar
    paths = [
        "test_files/prueba.html",  # Puede ser un archivo individual
        "test_files",                # O un directorio con varios HTMLs
    ]

    # Instanciar el procesador
    processor = HTMLProcessor()

    # Procesar los archivos o directorios
    resultados = processor.process(paths)

    # Mostrar los resultados
    print("Imágenes procesadas con éxito:")
    for item in resultados["success"]:
        print(item)

    print("\nImágenes que fallaron:")
    for item in resultados["fail"]:
        print(item)


if __name__ == "__main__":
    main()
