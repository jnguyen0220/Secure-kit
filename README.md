# Secure-Kit

A comprehensive security and database toolkit container with tools for secret scanning, database operations, and modern Python development.

## Table of Contents
- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Using with Dev Container](#using-with-dev-container)
- [Installed Tools](#installed-tools)
  - [Security & Secret Scanning](#security--secret-scanning)
  - [Database Tools](#database-tools)
  - [Python Package Management](#python-package-management)
  - [Base System Tools](#base-system-tools)
- [Usage Examples](#usage-examples)
  - [TruffleHog Examples](#trufflehog-examples)
  - [Nmap Examples](#nmap-examples)
  - [MongoDB Shell Examples](#mongodb-shell-examples)
  - [SQL Server Examples](#sql-server-examples)
- [Environment](#environment)

---

## Overview

This container is built on **Python 3.13** (Debian Bookworm) and includes essential tools for:
- 🔍 Secret scanning and security analysis
- 💾 MongoDB and SQL Server database operations
- 📦 Fast Python package management with `uv`

---

## Getting Started

### Using with Dev Container

This repository is configured to run as a VS Code Dev Container, providing a consistent development environment with all tools pre-installed.

#### Prerequisites
- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or Docker Engine on Linux)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code

#### Steps to Open in Dev Container

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd secure-kit
   ```

2. **Open in VS Code:**
   ```bash
   code .
   ```

3. **Reopen in Container:**
   - When prompted, click **"Reopen in Container"**
   - Or press `F1` and select **"Dev Containers: Reopen in Container"**
   - Or click the green icon in the bottom-left corner and select **"Reopen in Container"**

4. **Wait for container to build:**
   - The first time may take a few minutes as Docker builds the container
   - Subsequent opens will be much faster

5. **Start using the tools:**
   - All tools (trufflehog, mongosh, sqlcmd, uv) are immediately available in the integrated terminal
   - Open a new terminal with `` Ctrl+` `` or `Cmd+` `

#### Alternative: Build and Run Manually

If you prefer to run the container manually without VS Code:

```bash
# Build the container
docker build -t secure-kit .

# Run the container
docker run -it --rm -v $(pwd):/workspace secure-kit bash
```

---

## Installed Tools

### Security & Secret Scanning

#### TruffleHog
Secret scanning tool for finding leaked credentials and sensitive information in Git repositories.

- **Location:** `/usr/local/bin/trufflehog`
- **Source:** [TruffleHog](https://github.com/trufflesecurity/trufflehog)

#### Nmap
Network exploration tool and security/port scanner.

- **Location:** `/usr/bin/nmap`
- **Documentation:** [Nmap Official Site](https://nmap.org/)

---

### Database Tools

#### MongoDB Shell (mongosh)
Interactive shell for MongoDB database operations.

- **Location:** `/usr/local/bin/mongosh`
- **Version:** MongoDB 8
- **Documentation:** [MongoDB Shell](https://www.mongodb.com/docs/mongodb-shell/)

#### Microsoft SQL Server Tools (mssql-tools18)
Command-line utilities for SQL Server operations.

- **Location:** `/opt/mssql-tools18/bin/`
- **Included Tools:**
  - `sqlcmd` - Interactive SQL command-line utility
  - `bcp` - Bulk copy program for data import/export

---

### Python Package Management

#### uv & uvx
Ultra-fast Python package installer and runner.

- **uv Location:** `/usr/local/bin/uv`
- **uvx Location:** `/usr/local/bin/uvx`
- **Source:** [Astral UV](https://github.com/astral-sh/uv)
- **Description:**
  - `uv` - Extremely fast Python package installer and resolver
  - `uvx` - Python package runner (similar to pipx)

---

### Base System Tools

The following utilities are included for SSL/TLS, encryption, and system operations:

| Tool | Purpose |
|------|---------|
| Python 3.13 | Python runtime (slim-bookworm variant) |
| ca-certificates | Common CA certificates for SSL/TLS |
| curl | Command-line data transfer tool |
| gnupg2 | GNU Privacy Guard for encryption and signing |
| apt-transport-https | HTTPS support for APT package manager |
| unixodbc-dev | ODBC driver development libraries |

---

## Usage Examples

### TruffleHog Examples
**Scan a local Git repository:**
```bash
trufflehog git file:///path/to/your/repo
```

**Scan with username and PAT in URL:**
```bash
trufflehog git https://username:ghp_your_personal_access_token@github.com/username/repository.git
```

**Scan a GitHub organization:**
```bash
export GITHUB_TOKEN=ghp_your_personal_access_token_here
trufflehog github --org organization-name
```

#### Output Options

**Scan with JSON output:**
```bash
trufflehog github --repo https://github.com/username/repository --json
```

**Scan only verified secrets:**
```bash
trufflehog github --repo https://github.com/username/repository --only-verified
```

### Nmap Examples
**Basic host scan:**
```bash
nmap 192.168.1.1
```

**Scan specific ports:**
```bash
nmap -p 80,443,8080 192.168.1.1
```

**Scan port range:**
```bash
nmap -p 1-1000 192.168.1.1
```

**Scan all ports:**
```bash
nmap -p- 192.168.1.1
```

**Fast scan (most common 100 ports):**
```bash
nmap -F 192.168.1.1
```

#### Service and Version Detection

**Detect service versions:**
```bash
nmap -sV 192.168.1.1
```

**OS detection:**
```bash
nmap -O 192.168.1.1
```

**Aggressive scan (OS detection, version detection, script scanning, and traceroute):**
```bash
nmap -A 192.168.1.1
```

#### Scan Types

**TCP SYN scan (default, requires root):**
```bash
nmap -sS 192.168.1.1
```

**TCP connect scan (no root required):**
```bash
nmap -sT 192.168.1.1
```

**UDP scan:**
```bash
nmap -sU 192.168.1.1
```

#### Network Scanning

**Scan entire subnet:**
```bash
nmap 192.168.1.0/24
```

**Scan multiple hosts:**
```bash
nmap 192.168.1.1 192.168.1.2 192.168.1.3
```

**Scan from a list of hosts:**
```bash
nmap -iL hosts.txt
```

#### Output Options

**Save scan results to file:**
```bash
nmap -oN scan_results.txt 192.168.1.1
```

**Save as XML:**
```bash
nmap -oX scan_results.xml 192.168.1.1
```

**All output formats:**
```bash
nmap -oA scan_results 192.168.1.1
```

### MongoDB Shell Examples
**Connect to local MongoDB:**
```bash
mongosh
```

**Connect to MongoDB with username and password:**
```bash
mongosh "mongodb://username:password@localhost:27017"
```

**Connect to MongoDB Atlas or remote server:**
```bash
mongosh "mongodb+srv://username:password@cluster.mongodb.net/database"
```

**Connect with authentication database:**
```bash
mongosh --host localhost --port 27017 --username admin --password your_password --authenticationDatabase admin
```

**Connect to specific database:**
```bash
mongosh "mongodb://username:password@localhost:27017/myDatabase"
```

**Connect with additional options:**
```bash
mongosh "mongodb://username:password@localhost:27017/?authSource=admin&ssl=true"
```

### SQL Server Examples
**Connect to SQL Server with username and password:**
```bash
sqlcmd -S localhost -U sa -P 'YourPassword123!' -d master
```

**Connect to remote SQL Server with specific database:**
```bash
sqlcmd -S server.database.windows.net -U username -P 'YourPassword123!' -d mydatabase
```

**Connect with trusted connection (Windows Authentication):**
```bash
sqlcmd -S localhost -E -d mydatabase
```

#### Query Execution

**Execute a query directly:**
```bash
sqlcmd -S localhost -U sa -P 'YourPassword123!' -d mydatabase -Q "SELECT * FROM Users"
```

**Execute a SQL file:**
```bash
sqlcmd -S localhost -U sa -P 'YourPassword123!' -d mydatabase -i script.sql
```

#### Azure SQL & Advanced Options

**Connect with encryption (Azure SQL):**
```bash
sqlcmd -S server.database.windows.net -U username -P 'YourPassword123!' -d mydatabase -N -C
```

**Interactive mode with specific database:**
```bash
sqlcmd -S localhost -U sa -P 'YourPassword123!' -d mydatabase
# Then type queries and use 'GO' to execute
```

---

## Environment

**Base Image:** `python:3.13-slim-bookworm` (Debian Bookworm)

**Environment Variables:**
- `PATH` includes `/opt/mssql-tools18/bin` for direct access to SQL Server tools

**Container Features:**
- Lightweight Python 3.13 runtime
- Pre-configured SSL/TLS certificates
- ODBC drivers for database connectivity
- Modern package management with `uv`
