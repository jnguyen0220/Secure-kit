FROM mongo:8 AS mongo_builder

FROM golang:1.22-bullseye AS builder
RUN curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b /usr/local/bin


FROM python:3.13-slim-bookworm
WORKDIR /app
COPY --from=builder /usr/local/bin/trufflehog /usr/local/bin/trufflehog
COPY --from=ghcr.io/astral-sh/uv:bookworm-slim /usr/local/bin/uvx /usr/local/bin/uvx 
COPY --from=ghcr.io/astral-sh/uv:bookworm-slim /usr/local/bin/uv /usr/local/bin/uv

COPY --from=mongo_builder /usr/bin/mongosh /usr/local/bin/mongosh


RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y ca-certificates curl gnupg2 nmap git apt-transport-https \
    && update-ca-certificates \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
    && chmod 644 /usr/share/keyrings/microsoft-prod.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/msprod.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/opt/mssql-tools18/bin:${PATH}"