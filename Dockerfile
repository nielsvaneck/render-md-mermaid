FROM debian:9.5-slim

COPY entrypoint.sh /entrypoint.sh
COPY render-md-mermaid.sh /render-md-mermaid.sh

ENTRYPOINT ["/entrypoint.sh"]