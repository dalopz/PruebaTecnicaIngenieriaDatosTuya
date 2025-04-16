import base64
from pathlib import Path

class ImageBase64Converter:
    @staticmethod
    def convert_to_base64(image_path: Path) -> str:
        """
        Convierte una imagen en base64 e incluye el tipo MIME.

        Args:
            image_path (Path): Ruta de la imagen.

        Returns:
            str: Cadena base64 con tipo MIME o None si falla.
        """
        try:
            with open(image_path, 'rb') as file:
                encoded = base64.b64encode(file.read()).decode('utf-8')
                mime_type = f"image/{image_path.suffix[1:].lower()}"
                return f"data:{mime_type};base64,{encoded}"
        except Exception as e:
            print(f"Error al convertir {image_path}: {e}")
            return None
