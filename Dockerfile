# Use Python 3.13 slim image as base
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY server.py .

# Expose the default MCP port (if applicable)
# Note: MCP servers typically communicate via stdio, not network ports

# Add MCP server metadata
LABEL io.docker.server.metadata='{\
  "name": "roll-dice",\
  "description": "MCP server for rolling dice - generates random numbers",\
  "title": "Roll Dice",\
  "type": "server",\
  "env": [\
    {\
      "name": "DICE_SIDES",\
      "value": "{{roll-dice.sides}}"\
    }\
  ],\
  "config": [{\
  	"name": "roll-dice",\
	"description": "Configure roll-dice properties",\
	"type": "object",\
	"properties": {\
		"sides": {\
			"type":  "integer"\
		}\
	}\
  }],\
  "tools": [\
    {\
      "name": "roll",\
      "description": "Generate a random number between 1 and configured dice sides"\
    },\
    {\
      "name": "another_roll",\
      "description": "Generate a random number between 1 and configured dice sides"\
    }\
  ]\
}'

# Run the MCP server
CMD ["python", "server.py"]
