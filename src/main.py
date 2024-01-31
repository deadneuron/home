import datetime
import os
import re
import json
from jinja2 import Template


class Model:
    def __init__(self, src_location):
        # Filename including .ipynb
        self.filename = src_location.rsplit('/', 1)[-1]
        self.src_location = src_location
        self.build_location = "../build/models/" + \
            self.filename.replace(".ipynb", "")
        self.data = self.build_metadata()

    def build_metadata(self):
        with open(self.src_location) as f:
            text = f.read()
            name = re.search(r'NAME: (.*)\\n', text)
            year = re.search(r'YEAR: (.*)\\n', text)
            authors = re.search(r'AUTHORS: (.*)\\n', text)
            categories = re.search(r'CATEGORIES: (.*)\\n', text)
            description = re.search(r'DESCRIPTION: (.*)\\n', text)
            paper = re.search(r'PAPER: (.*)\\n', text)
            image = re.search(r'IMAGE: (.*)\"', text)

        return {
            'name': name.group(1),
            'year': year.group(1),
            'authors': authors.group(1),
            'categories': categories.group(1),
            'description': description.group(1),
            'paper': paper.group(1),
            'image': image.group(1) if image else None,
            'slug': os.path.join("/models", self.filename.replace('.ipynb', '')),
            'content': self.get_content()
        }

    def get_content(self):
        if not os.path.exists(os.path.join(self.build_location, "content.html")):
            self.compile()

        with open(os.path.join(self.build_location, "content.html"), 'r+') as f:
            content = f.read()

        return content

    def compile(self):
        os.system(
            f"jupyter nbconvert --TagRemovePreprocessor.remove_cell_tags='{{\"metadata\"}}' --no-prompt --to html --output 'content' --output-dir '{self.build_location}' {self.src_location}")

        with open(os.path.join(self.build_location, "content.html"), 'r+') as f:
            content = f.read()

            # Inject iframe resizer at the end of </head>
            f.seek(0)
            injected_content = content.replace(
                '</head>', '<script src="/static/iframeresizer.contentWindow.min.js"></script></head>')

            f.write(injected_content)


class Notebook:
    def __init__(self, src_location):
        # Filename including .ipynb
        self.filename = src_location.rsplit('/', 1)[-1]

        self.src_location = src_location
        self.build_location = "../build/notebooks/" + \
            self.filename.replace(".ipynb", "")

        self.data = self.build_metadata()

    def build_metadata(self):
        with open(self.src_location) as f:
            text = f.read()
            title = re.search(r'TITLE: (.*)\\n', text)
            categories = re.search(r'CATEGORIES: (.*)\\n', text)
            description = re.search(r'DESCRIPTION: (.*)\\n', text)
            authors = re.search(r'AUTHORS: (.*)\\n', text)
            source = re.search(r'SOURCE: (.*)\\n', text)
            date = re.search(r'DATE: (.*)\"', text)

        return {
            'title': title.group(1),
            'categories': categories.group(1),
            'description': description.group(1),
            'authors': authors.group(1) if authors else "",
            'source': source.group(1) if source else "",
            'date': date.group(1),
            'slug': os.path.join("/notebooks", self.filename.replace('.ipynb', '')),
            'content': self.get_content()
        }        

    def get_content(self):
        if not os.path.exists(os.path.join(self.build_location, "content.html")):
            self.compile()

        with open(os.path.join(self.build_location, "content.html"), 'r+') as f:
            content = f.read()

        return content

    def compile(self):
        os.system(
            f"jupyter nbconvert --TagRemovePreprocessor.remove_cell_tags='{{\"metadata\"}}' --no-prompt --to html --output 'content' --output-dir '{self.build_location}' {self.src_location}")

        with open(os.path.join(self.build_location, "content.html"), 'r+') as f:
            content = f.read()

            # Inject iframe resizer at the end of </head>
            f.seek(0)
            injected_content = content.replace(
                '</head>', '<link rel="stylesheet" href="/static/notebook-iframe.css" /><script src="/static/iframeresizer.contentWindow.min.js"></script></head>')

            f.write(injected_content)


def build_json(items, build_location):
    data = [x.data for x in items]

    with open(build_location, 'w+') as f:
        f.write(json.dumps(data))


def render_template(src_location, build_location, context=None):
    with open(src_location) as f:
        template = Template(f.read())
        rendered_template = template.render(context=context)

    with open(build_location, 'w+') as f:
        f.write(rendered_template)

def get_related_notebooks(notebook, notebooks):
    related = []
    categories = notebook.data["categories"].split()

    for n in notebooks:
        if n != notebook:
            for c in categories:
                if c in n.data["categories"]:
                    data = {
                        "date": n.data["date"],
                        "title":n.data["title"],
                        "description":n.data["description"],
                        "slug": n.data["slug"]
                    }
                    related.append(data)

    return related

# Loop through notebooks and build them
notebooks = []

for filename in os.listdir('notebooks'):
    if filename.endswith('.ipynb'):
        n = Notebook(os.path.join('notebooks', filename))
        notebooks.append(n)

# Compile notebooks
for n in notebooks:
    n.compile()
    n.data["related"] = get_related_notebooks(n, notebooks)

# Sort notebooks by date
notebooks.sort(key=lambda x: x.data['date'], reverse=True)

# Loop through models and build them
models = []

for filename in os.listdir('models'):
    if filename.endswith('.ipynb'):
        m = Model(os.path.join('models', filename))
        models.append(m)

# Compile models
# for m in models:
#     m.compile()

# Sort models by date
models.sort(key=lambda x: x.data['year'], reverse=True)

# Build json api endpoint (For react in the future?)
build_json(notebooks, "../build/notebooks/feed.json")
build_json(models, "../build/models/feed.json")

# Compile static assets
os.system("gulp")

# Render templates
render_template("templates/home.html",
                "../build/index.html",
                context=notebooks)

render_template("templates/about.html",
                "../build/about/index.html")

render_template("templates/models.html",
                "../build/models/index.html",
                context=models)

render_template("templates/research.html",
                "../build/research/index.html")

render_template("templates/notebooks.html",
                "../build/notebooks/index.html",
                context=notebooks)

for notebook in notebooks:
    render_template("templates/notebook.html",
                    f"{notebook.build_location}/index.html",
                    context=notebook)

for model in models:
    render_template("templates/model.html",
                    f"{model.build_location}/index.html",
                    context=model)
