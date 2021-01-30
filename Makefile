.PHONY: all build clean help test

all: help

build: render-md-mermaid

clean:
	@rm -f relative/path/to/rendered_image.svg

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | \
	sort | \
	awk 'BEGIN {FS = ":.*?## "}; \
		{printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

test: render-md-mermaid
	@ls relative/path/to/rendered_image.svg

-include render-md-mermaid.mk