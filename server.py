from fastmcp import FastMCP
import random
import os

mcp = FastMCP("Roll dice")

# Get dice sides from environment variable, default to 6
DICE_SIDES = int(os.getenv("DICE_SIDES", "6"))

@mcp.tool
def roll() -> int:
    """Generate a random number between 1 and configured dice sides"""
    return random.randint(1, DICE_SIDES)

@mcp.tool
def another_roll() -> int:
    """Generate a random number between 1 and configured dice sides"""
    return random.randint(1, DICE_SIDES)


if __name__ == "__main__":
    mcp.run()
