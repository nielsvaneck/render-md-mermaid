# FROM debian:9.5-slim
FROM minlag/mermaid-cli:latest

# Add bash & perl
USER root
RUN apk add bash perl
USER mermaidcli

COPY entrypoint.sh /entrypoint.sh
COPY render-md-mermaid.sh /render-md-mermaid.sh

ENTRYPOINT ["/entrypoint.sh"]
