using Godot;
using System;

namespace Game.Board;

public static partial class BoardMovement
{
	//private:
		class TilePath
		{
			public Tile? tile;
			public TilePath?[] adjacentTiles;

			public TilePath()
			{
				this.tile = null;
				this.adjacentTiles = [null, null, null, null];
			}
		}

		static TilePath? calculatePaths(ref GameState game, Point2D position, int distance, bool reverse = false, int depth = 0)
		{
			//get current tile
			TilePath output = new TilePath();
			output.tile = game.getTile(position);

			//if tile doesn't exist for some reason, end early
			if(output.tile is null)
			{
				return null;
			}
			
			//if current tile is slippery, increase distance to account for it
			if(output.tile.getType() == TileType.Slippery) //tile will always be non-null if it was retrieved
			{
				distance++;
			}

			//check if there's still distance left to travel, or if the anti-infinite-loop limit has been reached
			//if so end without checking for adjacent tiles
			if (distance <= 0 | depth >= 100)
			{
				return output;
			}

			//continue search along tile outs
			if (output.tile.getInOut(Direction.North) == (reverse ? IO.In : IO.Out))
			{
				output.adjacentTiles[(int)Direction.North] = calculatePaths(ref game, new Point2D(position.x, position.y+1), distance-1, reverse, depth+1);
			}
			if (output.tile.getInOut(Direction.West) == (reverse ? IO.In : IO.Out))
			{
				output.adjacentTiles[(int)Direction.West] = calculatePaths(ref game, new Point2D(position.x-1, position.y), distance-1, reverse, depth+1);
			}
			if (output.tile.getInOut(Direction.East) == (reverse ? IO.In : IO.Out))
			{
				output.adjacentTiles[(int)Direction.East] = calculatePaths(ref game, new Point2D(position.x+1, position.y), distance-1, reverse, depth+1);
			}
			if (output.tile.getInOut(Direction.South) == (reverse ? IO.In : IO.Out))
			{
				output.adjacentTiles[(int)Direction.South] = calculatePaths(ref game, new Point2D(position.x, position.y-1), distance-1, reverse, depth+1);
			}

			//all done
			return output;
		}

	//public
		public static void move(ref GameState game, ref PlayerCharacter pc, int diceCount = 1, int tempMoveMod = 0, bool reverse = false)
		{
			//TODO: rewrite to tie in with actual dice function
			int moveDistance = Dice.rollDice(diceCount).Sum() + pc.getMoveMod() + tempMoveMod;

			TilePath? paths = calculatePaths(ref game, pc.getPosition(), moveDistance, (pc.getMoveReversed() ^ reverse));
			
			while (paths is not null)
			{
				//move character to current step of path
				//renderMoveCharacter(pc, paths.tile.getX(), paths.tile.getY()); //TODO

				//determine next step
				bool[] directionValid = [
					paths.adjacentTiles[(int)Direction.North] is not null,
					paths.adjacentTiles[(int)Direction.West]  is not null,
					paths.adjacentTiles[(int)Direction.East]  is not null,
					paths.adjacentTiles[(int)Direction.South] is not null
				];

				int directionCount = (directionValid[(int)Direction.North]? 1 : 0) + (directionValid[(int)Direction.West]? 1 : 0) + (directionValid[(int)Direction.East] ? 1 : 0) + (directionValid[(int)Direction.South] ? 1 : 0);

				if (directionCount == 0)
				{
					paths = null;
				}
				else if (directionCount == 1)
				{
					if      (directionValid[(int)Direction.North]) {paths = paths.adjacentTiles[(int)Direction.North];}
					else if (directionValid[(int)Direction.West ]) {paths = paths.adjacentTiles[(int)Direction.West ];}
					else if (directionValid[(int)Direction.East ]) {paths = paths.adjacentTiles[(int)Direction.East ];}
					else if (directionValid[(int)Direction.South]) {paths = paths.adjacentTiles[(int)Direction.South];}
				}
				else if (directionCount > 1)
				{
					paths = paths.adjacentTiles[(int)PlayerInput.getInputMoveDirection(ref game, directionValid)];
				}
			}
		}
}
