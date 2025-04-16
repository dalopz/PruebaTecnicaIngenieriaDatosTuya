import sys
from pathlib import Path
from html_image_base64.processor import HTMLProcessor

def main():

    if len(sys.argv) < 2:
        print("Por favor, pasa al menos un directorio o archivo HTML para procesar.")
        sys.exit(1)

    paths = sys.argv[1:]

    # Se instancia el procesador con la carpeta de salida por defecto ('outputs')
    processor = HTMLProcessor(output_dir="outputs")

    # Procesar los archivos HTML
    results = processor.process(paths)

    print("\nImágenes procesadas con éxito:")
    for success in results["success"]:
        print(f" - {success}")

    print("\nImágenes que fallaron:")
    for fail in results["fail"]:
        print(f" - {fail}")

if __name__ == "__main__":
    main()
