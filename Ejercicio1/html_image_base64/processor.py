import os
from pathlib import Path
from html_image_base64.parser import HTMLImageParser
from html_image_base64.converter import ImageBase64Converter

class HTMLProcessor:
    def __init__(self):
        self.results = {"success": [], "fail": []}

    def process(self, paths):
        html_files = self._gather_html_files(paths)

        for file_path in html_files:
            try:
                html_content = file_path.read_text(encoding='utf-8')
                parser = HTMLImageParser()
                parser.feed(html_content)

                for img_src in parser.get_img_sources():
                    img_path = (file_path.parent / img_src).resolve()
                    base64_data = ImageBase64Converter.convert_to_base64(img_path)

                    if base64_data:
                        html_content = html_content.replace(f'src="{img_src}"', f'src="{base64_data}"')
                        self.results["success"].append(str(img_path))
                    else:
                        self.results["fail"].append(str(img_path))

                output_path = file_path.with_name(file_path.stem + "_base64.html")
                output_path.write_text(html_content, encoding='utf-8')

            except Exception as e:
                print(f"Error procesando {file_path}: {e}")
                self.results["fail"].append(str(file_path))

        return self.results

    def _gather_html_files(self, paths):
        files = []
        for path_str in paths:
            path = Path(path_str)
            if path.is_file() and path.suffix.lower() == ".html":
                files.append(path)
            elif path.is_dir():
                files.extend(path.rglob("*.html"))
        return files
