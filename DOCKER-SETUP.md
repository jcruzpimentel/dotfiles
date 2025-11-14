# Docker Context Setup for TrueNAS

This guide explains how to set up Docker to use TrueNAS as the default context, allowing you to run all Docker commands from your Mac while they execute on TrueNAS.

## Prerequisites

- SSH access to TrueNAS (already configured in `~/.ssh/config` as `truenas`)
- Docker installed on your Mac (`brew install docker`)
- Docker Compose plugin installed (`brew install docker-compose`)
- Docker enabled on TrueNAS

## One-Time Setup

### 1. Test SSH Connection

First, verify you can SSH into TrueNAS:

```bash
ssh truenas
```

If this works, you're ready to proceed. Exit the SSH session.

### 2. Configure Docker Compose Plugin

Add the Homebrew Docker plugins directory to your Docker config:

Edit `~/.docker/config.json` and add:

```json
{
  "cliPluginsExtraDirs": [
    "/opt/homebrew/lib/docker/cli-plugins"
  ]
}
```

### 3. Create Docker Context for TrueNAS

Create a new Docker context that connects to TrueNAS via SSH:

```bash
docker context create truenas --docker "host=ssh://truenas"
```

### 4. Set TrueNAS as Default Context

Make TrueNAS the default context so all Docker commands run there by default:

```bash
docker context use truenas
```

### 5. Verify Setup

Test that Docker commands are running on TrueNAS:

```bash
docker ps
docker info
docker compose version
```

You should see containers and system info from your TrueNAS server.

## Daily Usage

### Running Docker Commands

All standard Docker commands now execute on TrueNAS:

```bash
# List containers on TrueNAS
docker ps

# View logs
docker logs <container-name>

# Execute commands in containers
docker exec -it <container-name> bash

# Pull images (downloads to TrueNAS)
docker pull nginx

# Run containers on TrueNAS
docker run -d nginx
```

### Docker Compose

Docker Compose commands work seamlessly with the context:

```bash
# All compose commands execute on TrueNAS
docker compose up -d
docker compose down
docker compose restart <service>
docker compose logs -f
docker compose ps

# Note: File paths in docker-compose.yml refer to TrueNAS filesystem
# You'll typically SSH to TrueNAS and work from there:
ssh truenas
cd /mnt/HDDs/Admin/repos/gaming-servers
docker compose up -d
```

### Switching Contexts (if needed)

If you ever need to run Docker locally:

```bash
# Switch to local Docker
docker context use default

# Switch back to TrueNAS
docker context use truenas

# List all contexts
docker context ls
```

## Troubleshooting

### "Cannot connect to Docker daemon"

This usually means SSH authentication failed. Test your SSH connection:

```bash
ssh truenas
```

### "Context not found"

Recreate the context:

```bash
docker context create truenas --docker "host=ssh://truenas"
docker context use truenas
```

### Check Current Context

```bash
docker context show
```

## Notes

- File paths in `docker run` commands refer to the TrueNAS filesystem, not your Mac
- For bind mounts, paths must exist on TrueNAS
- Port mappings expose ports on TrueNAS, not your Mac
- To access services, use TrueNAS IP (10.10.10.253) in your browser
