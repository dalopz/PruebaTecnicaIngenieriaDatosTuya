from html.parser import HTMLParser

class HTMLImageParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.img_sources = []

    def handle_starttag(self, tag, attrs):
        if tag.lower() == "img":
            attrs_dict = dict(attrs)
            src = attrs_dict.get("src")
            if src:
                self.img_sources.append(src)

    def get_img_sources(self):
        return self.img_sources
