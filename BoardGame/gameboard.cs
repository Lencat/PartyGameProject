using Godot;
using System;
using System.Collections.Generic;

namespace Game.Board;

public partial class GameBoard : Node
{
	private:
		Dictionary<Point2D, Tile> tileGrid;
		Point2D mapSize;
		Point2D startTile;

	public:
		GameBoard() {
			tileGrid = new Dictionary<Point2D, Tile>;
			mapSize = Point2D(0,0);
			startPoint = Point2D(0,0);
		}

		GameBoard(file mapLayout) {
			throw new NotImplementedException("Load from file not implemented.");
			//store in a json eventually
		}

		void temp_load_map_graveyard() {
			mapSize = Point2D(8,7);
			startPoint = Point2D(7,0);
			
			tileGrid;

			tileGrid[7][0].type = TileType.Home;
				tileGrid[7][0].inOutNWES[Direction.West]  = IO.In;
				tileGrid[7][0].inOutNWES[Direction.North] = IO.Out;
			tileGrid[7][1].type = TileType.Dash;
				tileGrid[7][1].inOutNWES[Direction.South] = IO.In;
				tileGrid[7][1].inOutNWES[Direction.North] = IO.Out;
			tileGrid[7][2].type = TileType.Clue;
				tileGrid[7][2].inOutNWES[Direction.South] = IO.In;
				tileGrid[7][2].inOutNWES[Direction.North] = IO.Out;
			tileGrid[7][3].type = TileType.Blank;
				tileGrid[7][3].inOutNWES[Direction.South] = IO.In;
				tileGrid[7][3].inOutNWES[Direction.North] = IO.Out;
			tileGrid[7][4].type = TileType.Haunt;
				tileGrid[7][4].inOutNWES[Direction.South] = IO.In;
				tileGrid[7][4].inOutNWES[Direction.North] = IO.Out;
			tileGrid[7][5].type = TileType.Blank;
				tileGrid[7][5].inOutNWES[Direction.South] = IO.In;
				tileGrid[7][5].inOutNWES[Direction.North] = IO.Out;
			tileGrid[7][6].type = TileType.Dash;
				tileGrid[7][6].inOutNWES[Direction.South] = IO.In;
				tileGrid[7][6].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[6][6].type = TileType.Blank;
				tileGrid[6][6].inOutNWES[Direction.East]  = IO.In;
				tileGrid[6][6].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[5][6].type = TileType.Dash;
				tileGrid[5][6].inOutNWES[Direction.East]  = IO.In;
				tileGrid[5][6].inOutNWES[Direction.West]  = IO.Out;
				tileGrid[5][6].inOutNWES[Direction.South] = IO.Out;

			tileGrid[4][6].type = TileType.Blank;
				tileGrid[4][6].inOutNWES[Direction.East]  = IO.In;
				tileGrid[4][6].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[3][6].type = TileType.Blank;
				tileGrid[3][6].inOutNWES[Direction.East]  = IO.In;
				tileGrid[3][6].inOutNWES[Direction.South] = IO.Out;
			tileGrid[3][5].type = TileType.Clue;
				tileGrid[3][5].inOutNWES[Direction.North] = IO.In;
				tileGrid[3][5].inOutNWES[Direction.South] = IO.Out;
			tileGrid[3][4].type = TileType.Blank;
				tileGrid[3][4].inOutNWES[Direction.North] = IO.In;
				tileGrid[3][4].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[2][4].type = TileType.Blank;
				tileGrid[2][4].inOutNWES[Direction.East]  = IO.In;
				tileGrid[2][4].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[1][4].type = TileType.Clue;
				tileGrid[1][4].inOutNWES[Direction.East]  = IO.In;
				tileGrid[1][4].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[0][4].type = TileType.Blank;
				tileGrid[0][4].inOutNWES[Direction.East]  = IO.In;
				tileGrid[0][4].inOutNWES[Direction.South] = IO.Out;
			tileGrid[0][3].type = TileType.Blank;
				tileGrid[0][3].inOutNWES[Direction.North] = IO.In;
				tileGrid[0][3].inOutNWES[Direction.South] = IO.Out;

			tileGrid[5][5].type = TileType.Haunt;
				tileGrid[5][5].inOutNWES[Direction.North] = IO.In;
				tileGrid[5][5].inOutNWES[Direction.South] = IO.Out;
			tileGrid[5][4].type = TileType.Clue;
				tileGrid[5][4].inOutNWES[Direction.North] = IO.In;
				tileGrid[5][4].inOutNWES[Direction.South] = IO.Out;
			tileGrid[5][3].type = TileType.Haunt;
				tileGrid[5][3].inOutNWES[Direction.North] = IO.In;
				tileGrid[5][3].inOutNWES[Direction.South] = IO.Out;
			tileGrid[5][2].type = TileType.Dash;
				tileGrid[5][2].inOutNWES[Direction.North] = IO.In;
				tileGrid[5][2].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[4][2].type = TileType.Haunt;
				tileGrid[4][2].inOutNWES[Direction.East] = IO.In;
				tileGrid[4][2].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[3][2].type = TileType.Clue;
				tileGrid[3][2].inOutNWES[Direction.East] = IO.In;
				tileGrid[3][2].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[2][2].type = TileType.Haunt;
				tileGrid[2][2].inOutNWES[Direction.East] = IO.In;
				tileGrid[2][2].inOutNWES[Direction.West]  = IO.Out;
			tileGrid[1][2].type = TileType.Clue;
				tileGrid[1][2].inOutNWES[Direction.East] = IO.In;
				tileGrid[1][2].inOutNWES[Direction.West]  = IO.Out;

			tileGrid[0][2].type = TileType.Dash;
				tileGrid[0][2].inOutNWES[Direction.North] = IO.In;
				tileGrid[0][2].inOutNWES[Direction.East]  = IO.In;
				tileGrid[0][2].inOutNWES[Direction.South] = IO.Out;
			tileGrid[0][1].type = TileType.Blank;
				tileGrid[0][1].inOutNWES[Direction.North] = IO.In;
				tileGrid[0][1].inOutNWES[Direction.South] = IO.Out;
			tileGrid[0][0].type = TileType.Dash;
				tileGrid[0][0].inOutNWES[Direction.North] = IO.In;
				tileGrid[0][0].inOutNWES[Direction.East] = IO.Out;
			tileGrid[1][0].type = TileType.Blank;
				tileGrid[1][0].inOutNWES[Direction.West] = IO.In;
				tileGrid[1][0].inOutNWES[Direction.East] = IO.Out;
			tileGrid[2][0].type = TileType.Clue;
				tileGrid[2][0].inOutNWES[Direction.West] = IO.In;
				tileGrid[2][0].inOutNWES[Direction.East] = IO.Out;
			tileGrid[3][0].type = TileType.Blank;
				tileGrid[3][0].inOutNWES[Direction.West] = IO.In;
				tileGrid[3][0].inOutNWES[Direction.East] = IO.Out;
			tileGrid[4][0].type = TileType.Haunt;
				tileGrid[4][0].inOutNWES[Direction.West] = IO.In;
				tileGrid[4][0].inOutNWES[Direction.East] = IO.Out;
			tileGrid[5][0].type = TileType.Haunt;
				tileGrid[5][0].inOutNWES[Direction.West] = IO.In;
				tileGrid[5][0].inOutNWES[Direction.East] = IO.Out;
			tileGrid[6][0].type = TileType.Haunt;
				tileGrid[6][0].inOutNWES[Direction.West] = IO.In;
				tileGrid[6][0].inOutNWES[Direction.East] = IO.Out;
		}
}
