# MCP Dice Server

An MCP (Model Context Protocol) server that provides dice rolling functionality with configurable dice sides.

## Overview

This server provides two tools:
- `roll`: Generate a random number between 1 and configured dice sides
- `another_roll`: Generate a random number between 1 and configured dice sides

The number of dice sides is configurable via the `DICE_SIDES` environment variable (defaults to 6).

## Deployment Options

This project demonstrates different approaches to deploying containerized MCP servers in the catalog.

### Self-Configured Image with Embedded Metadata

**File:** `build.sh`

The `build.sh` script builds a Docker image with embedded metadata in an image label. This creates a "self-configured" image that contains all the information needed for the catalog without requiring a separate metadata file.

```bash
./build.sh
```

When using a self-configured image, you can add the server to the catalog using an OCI reference with the `docker://` protocol:

```bash
docker mcp gateway run --server docker://roberthouse224/roll-dice:latest
```

The metadata is embedded in the `io.docker.server.metadata` label during the build process, making the image completely self-describing.

For more information about self-configured images, see the [self-configured documentation](https://github.com/docker/mcp-gateway/blob/main/docs/self-configured.md).

### External Metadata Files

If your image doesn't have the special metadata label, you can provide the metadata from a separate YAML file using the `file://` protocol.

For details on the YAML file format and server entry specification, see the [server entry spec documentation](https://github.com/docker/mcp-gateway/blob/main/docs/server-entry-spec.md).

#### Docker Hub Image

**File:** `mcp-dice-docker.yaml`

This file demonstrates how to reference an image stored on Docker Hub:

```bash
docker mcp gateway run --server file://mcp-dice-docker.yaml
```

The YAML file specifies:
- Image location: `roberthouse224/roll-dice:latest` (Docker Hub)
- Tool definitions
- Configuration schema
- Environment variable mappings

#### GitHub Container Registry Image

**File:** `mcp-dice-ghcr.yaml`

This file demonstrates how to reference an image stored on GitHub Container Registry (GHCR):

```bash
docker mcp gateway run --server file://mcp-dice-ghcr.yaml
```

The YAML file specifies:
- Image location: `ghcr.io/bobbyhouse/roll-dice:latest` (GHCR)
- Tool definitions
- Configuration schema
- Environment variable mappings

## Configuration

All three deployment methods support the same configuration:

```yaml
dice_sides: 6  # Number of sides on the dice (default: 6)
```

This configuration is passed to the container via the `DICE_SIDES` environment variable.

## Creating Catalogs

To create your own catalog with MCP servers, see the [creating catalogs documentation](https://github.com/docker/mcp-gateway/blob/main/docs/profiles.md#creating-catalogs).

## Learn More

- [Self-configured images](https://github.com/docker/mcp-gateway/blob/main/docs/self-configured.md)
- [Server entry specification](https://github.com/docker/mcp-gateway/blob/main/docs/server-entry-spec.md)
- [Creating catalogs](https://github.com/docker/mcp-gateway/blob/main/docs/profiles.md#creating-catalogs)
