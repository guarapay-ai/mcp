# GuaraPay AI Payment Agent — stdio bridge to the remote MCP server at https://mcp.guarapay.io
# for MCP clients that only speak stdio. Sign-in is OAuth in your browser; tokens stay in /data.
FROM node:22-alpine
LABEL org.opencontainers.image.source="https://github.com/guarapay-ai/mcp" \
      org.opencontainers.image.title="GuaraPay MCP" \
      org.opencontainers.image.description="AI Payment Agent: stdio bridge to the GuaraPay MCP server (mcp.guarapay.io). Virtual cards your AI agent pays with, within your limits." \
      org.opencontainers.image.url="https://guarapay.io/en/ai-agents/" \
      io.modelcontextprotocol.server.name="io.guarapay/card"
RUN npm install -g --omit=dev mcp-remote@0.16.7 && npm cache clean --force && mkdir /data && chown node:node /data
USER node
ENV MCP_REMOTE_CONFIG_DIR=/data
VOLUME /data
EXPOSE 3334
ENTRYPOINT ["mcp-remote", "https://mcp.guarapay.io", "3334", "--bind-host", "0.0.0.0"]
