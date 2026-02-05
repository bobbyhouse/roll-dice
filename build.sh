#!/bin/bash

# Only run this if you want to build a self-describing image.
#
# This is not required if you use a yaml file to provide metadata for the catalog.

# Build the self-configured MCP dice server
docker build \
  --label "io.docker.server.metadata=$(cat <<'EOF'
name: roll-dice
title: Roll Dice
description: An MCP server that can roll a dice for you
command: ["python", "/app/server.py"]
tools:
  - name: roll
    description: Generate a random number between 1 and configured dice sides
    arguments: []
    annotations:
      idempotentHint: false
  - name: another_roll
    description: Generate a random number between 1 and configured dice sides
    arguments: []
    annotations:
      idempotentHint: false
config:
  - name: roll-dice
    type: object
    description: Configuration for dice rolling behavior
    properties:
      dice_sides:
        type: integer
        description: Number of sides on the dice (default is 6)
        default: 6
env:
  - name: DICE_SIDES
    value: "{{roll-dice.dice_sides}}"
EOF
)" \
  -t roberthouse224/roll-dice:latest .

echo ""
echo "Build complete! You can now run the server with:"
echo "docker mcp gateway run --servers docker://roberthouse224/roll-dice:latest"
