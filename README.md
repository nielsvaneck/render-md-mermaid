# render-md-mermaid

[![render-md-mermaid](https://github.com/nielsvaneck/render-md-mermaid/actions/workflows/render-md-mermaid.yml/badge.svg)](https://github.com/nielsvaneck/render-md-mermaid/actions/workflows/render-md-mermaid.yml)
<a href="https://github.com/search?o=desc&q=nielsvaneck%2Frender-md-mermaid+path%3A.github%2Fworkflows+language%3AYAML&s=&type=Utility" target="_blank" title="Public workflows that use this action."><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fapi-git-master.endbug.vercel.app%2Fapi%2Fgithub-actions%2Fused-by%3Faction%3Dnielsvaneck%2Frender-md-mermaid%26badge%3Dtrue" alt="Public workflows that use this action."></a>

A GitHub Action and Utility for rendering Mermaid-JS diagrams in Markdown files for display on GitHub.

Documentation is good. Diagrams are good. But with all good things, if they are hard to do, we do less of them. [Mermaid](https://mermaid-js.github.io/mermaid/#/) makes it very easy to create diagrams and this tool makes using Mermaid diagrams in Markdown documents a breeze. It is inspired by [Typora's Mermaid support](https://support.typora.io/Draw-Diagrams-With-Markdown/) and uses a simple trick that hides the diagram source and displays a rendered diagram image instead, when reading the document on GitHub. Keeping diagrams up-to-date is easy because the diagram source is in the Markdown file. No need to go off to the live-editor and copy things back and forth.

## Mermaid in Markdown

`render-md-mermaid` will pick up any Mermaid graph in Markdown files that is defined as:

~~~markdown
![rendered image description](relative/path/to/rendered_image. svg or png )
<details>
  <summary>diagram source</summary>
  This details block is collapsed by default when viewed in GitHub. This hides the mermaid graph definition, while the rendered image
  linked above is shown. The details tag has to follow the image tag. (newlines allowed)

```mermaid
graph LR
    A[README.md]
    B{Find mermaid graphs<br>and image paths}
    C[[docker mermaid-cli]]
    D[[docker mermaid-cli]]
    E(Graph 1 png image)
    F(Graph 2 svg image)

    A -->|passed to| B
    subgraph render-md-mermaid.sh
      B --> |path/to/image1.png<br>+mermaid source| C
      B --> |path/to/image2.svg<br>+mermaid source| D
    end
    C --> E
    D --> F
```
</details>
~~~

The script will pick up the graph definition from the mermaid code block and render it to the image file and path specified in the
image tag using [mermaid-cli](https://github.com/mermaid-js/mermaid-cli). The rendered image can be in svg or png format, whatever is specified will be generated. The result is displayed like this:

![rendered image description](relative/path/to/rendered_image.png)
<details>
  <summary>diagram source</summary>
  This details block is collapsed by default when viewed in GitHub.
  This hides the mermaid graph definition, while the rendered image
  linked above is shown.
  The details tag has to follow the image tag. (newlines allowed)

```mermaid
graph LR
    A[README.md<br>with Mermaid diagram]
    B{Find mermaid graphs<br>and image paths}
    C[[docker mermaid-cli]]
    D[[docker mermaid-cli]]
    E(Graph 1 png image)
    F(Graph 2 svg image)

    A -->|passed to| B
    subgraph render-md-mermaid.sh
      B --> |path/to/image1.png<br>+mermaid source| C
      B --> |path/to/image2.svg<br>+mermaid source| D
    end
    C --> E
    D --> F
```

</details>

When using the GitHub Action, this will automatically happen for every Markdown file in the repository.

For a great Markdown reading / editing experience (including live-rendering of your mermaid graphs), give [Typora](https://typora.io) a try!

## GitHub Action / Workflow example

Include the following GitHub Action workflow definition in your project to automatically render and [commit](https://github.com/stefanzweifel/git-auto-commit-action) images from Mermaid diagrams in your Markdown files.

```yaml
# .github/workflows/render-md-mermaid.yml

name: render-md-mermaid

on:
  push:
    paths:
      - '**.md'

jobs:
  render-md-mermaid:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Render images for every Mermaid diagram in all Markdown files (*.md) in the repo
        uses: nielsvaneck/render-md-mermaid@v2

      - name: Commit rendered png and svg files
        uses: stefanzweifel/git-auto-commit-action@v4
        with:
          file_pattern: "*[.svg,.png]"
          commit_message: automatically rendered mermaid diagrams
```

## render-md-mermaid.sh

The script can be invoked on any Markdown file to render embedded mermaid diagrams, provided they are presented in the format described above.

```shell
$ ./render-md-mermaid.sh README.md
Markdown file: README.md
Generated: ./relative/path/to/rendered_image.png

```

## Makefile include

This repo can be used as a submodule by running: `git submodule add git@github.com:nielsvaneck/render-md-mermaid.git SUBMODULE/DIRECTORY` in the root of your git repository.

It offers `render-md-mermaid.mk` as a Makefile include. See `Makefile` for an example integration.

Once `render-md-mermaid.mk` is included, `make render-md-mermaid` will invoke the `render-md-mermaid.sh` script on all Markdown files in the repository and write rendered diagrams to the specified image files.
