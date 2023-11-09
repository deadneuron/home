import os
import re
import json
from jinja2 import Template


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
            date = re.search(r'DATE: (.*)\\n', text)
            hero = re.search(r'HERO: (.*)\"', text)

        return {
            'title': title.group(1),
            'categories': categories.group(1),
            'description': description.group(1),
            'date': date.group(1),
            'hero': hero.group(1),
            'slug': os.path.join("/notebooks", self.filename.replace('.ipynb', '')),
            'content': self.get_content()
        }

    def get_content(self):
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
            self.data['content'] = content.replace(
                '</head>', '<script src="/static/iframeresizer.contentWindow.min.js"></script></head>')

            f.write(self.data['content'])


def build_json(notebooks):
    data = [n.data for n in notebooks]

    with open('../build/notebooks/feed.json', 'w+') as f:
        f.write(json.dumps(data))


def render_template(src_location, build_location, context=None):
    with open(src_location) as f:
        template = Template(f.read())
        rendered_template = template.render(context=context)

    with open(build_location, 'w+') as f:
        f.write(rendered_template)


# Loop through notebooks and build them
notebooks = []

for filename in os.listdir('notebooks'):
    if filename.endswith('.ipynb'):
        n = Notebook(os.path.join('notebooks', filename))
        notebooks.append(n)

# Compile notebooks
# for n in notebooks:
#     n.compile()

# Build json api endpoint (For react in the future?)
build_json(notebooks)

# Compile static assets
os.system("gulp")

# Render templates
render_template("templates/home.html",
                "../build/index.html",
                context=notebooks)

render_template("templates/about.html",
                "../build/about/index.html")

render_template("templates/models.html",
                "../build/models/index.html")

render_template("templates/publications.html",
                "../build/publications/index.html")

render_template("templates/notebooks.html",
                "../build/notebooks/index.html",
                context=notebooks)

for notebook in notebooks:
    render_template("templates/notebook.html",
                    f"{notebook.build_location}/index.html",
                    context=notebook)
