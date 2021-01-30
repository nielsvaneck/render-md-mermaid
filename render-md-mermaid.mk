.PHONY: render-md-mermaid

render-md-mermaid: $(shell find . -name "render-md-mermaid.sh") $(shell find . -name "*.md") ## Render all mermaid graphs in any .md file in the repository
	@for md in $(shell find . -name "*.md"); do echo "$<"; "./$<" "$$md"; done