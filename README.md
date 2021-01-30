# render-md-mermaid

GitHub Action & utility for rendering Mermaid-JS diagrams in MD files for display on GitHub

## render-md-mermaid.sh

This script can be invoked on any Markdown file to render embedded mermaid diagrams, provided they are presented in the following format:

~~~markdown
![rendered image description](relative/path/to/rendered_image. svg or png )
<details>
  <summary>diagram source</summary>
  This details block is collapsed by default when viewed in GitHub. This hides the mermaid graph definition, while the rendered image
  linked above is shown. The details tag has to follow the image tag. (newlines allowed)

```mermaid
graph LR
    A[README.md] -->|passed to| B
    subgraph render-md-mermaid.sh
    B{Find mermaid graphs<br>and image paths} --> C(docker mermaid-cli)
    B --> D(docker mermaid-cli)
    end
    C -->|path/to/image1.png| E(Graph 1 png image)
    D -->|path/to/image2.svg| F(Graph 2 svg image)
```
</details>
~~~

The script will pick up the graph definition from the mermaid code bloc and render it to the image file and path specified in the
image tag using the docker version of mermaid-cli. The rendered image can be in svg or png format, whatever is specified will be generated. The result is rendered as follows:

![rendered image description](relative/path/to/rendered_image.png)
<details>
  <summary>diagram source</summary>
  This details block is collapsed by default when viewed in GitHub. This hides the mermaid graph definition, while the rendered image
  linked above is shown. The details tag has to follow the image tag. (newlines allowed)

```mermaid
graph LR
    A[README.md] -->|passed to| B
    subgraph render-md-mermaid.sh
    B{Find mermaid graphs<br>and image paths} --> C(docker mermaid-cli)
    B --> D(docker mermaid-cli)
    end
    C -->|path/to/image1.png| E(Graph 1 png image)
    D -->|path/to/image2.svg| F(Graph 2 svg image)
```

</details>

## Makefile include

This repo can be used as a submodule by running: `git submodule add git@github.com:nielsvaneck/render-md-mermaid.git SUBMODULE/PATH` in the root of your git repository.

It offers `render-md-mermaid.mk` as a Makefile include. See `Makefile` for an example integration.

Once `render-md-mermaid.mk` is included, `make render-md-mermaid` will invoke the `render-md-mermaid.sh` script on all Markdown files in the repository and write rendered diagrams to the specified image files.

## GitHub Action

WIP
