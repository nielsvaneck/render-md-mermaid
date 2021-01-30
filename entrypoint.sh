#!/usr/bin/env bash
for md in $(find . -name "*.md"); do /render-md-mermaid.sh "$md"; done