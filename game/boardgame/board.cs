using Godot;
using System;
using System.Collections.Generic;

namespace Game.Board;

public partial class Board
{
	//private
		private Point2D mapSize;
		private Point2D startingPoint;
		private Dictionary<Point2D, Tile> tileDict;

	//public
		public Board()
		{
			this.tileDict = new Dictionary<Point2D, Tile>();
			this.mapSize = new Point2D(0,0);
			this.startingPoint = new Point2D(0,0);
		}

		public Board(string mapFilepath)
		{
			throw new NotImplementedException("Load from file not implemented.");
			//store in a json eventually

			//relayTilePositions();
		}

		public void relayTilePositions()
		{
			foreach(KeyValuePair<Point2D,Tile> entry in this.tileDict)
			{
				entry.Value.setPosition(entry.Key);
			}
		}

		public Tile? getTile(Point2D position)
		{
			Tile? tile = null;
			bool successful = this.tileDict.TryGetValue(position, out tile);
			if (successful)
			{
				return tile;
			}
			else
			{
				return null;
			}
		}

		public Point2D getStartingPoint() {return this.startingPoint;}

		public void temp_load_map_graveyard()
		{
			mapSize = new Point2D(8,7);
			startingPoint = new Point2D(7,0);
			
			//                                                      North    West     East     South
			tileDict.Add(new Point2D(7,0), new Tile(TileType.Home,  IO.Out,  IO.In,   IO.None, IO.None));
			tileDict.Add(new Point2D(7,1), new Tile(TileType.Dash,  IO.Out,  IO.None, IO.None, IO.In  ));
			tileDict.Add(new Point2D(7,2), new Tile(TileType.Clue,  IO.Out,  IO.None, IO.None, IO.In  ));
			tileDict.Add(new Point2D(7,3), new Tile(TileType.Blank, IO.Out,  IO.None, IO.None, IO.In  ));
			tileDict.Add(new Point2D(7,4), new Tile(TileType.Haunt, IO.Out,  IO.None, IO.None, IO.In  ));
			tileDict.Add(new Point2D(7,5), new Tile(TileType.Blank, IO.Out,  IO.None, IO.None, IO.In  ));
			tileDict.Add(new Point2D(7,6), new Tile(TileType.Dash,  IO.None, IO.Out,  IO.None, IO.In  ));
			tileDict.Add(new Point2D(6,6), new Tile(TileType.Blank, IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(5,6), new Tile(TileType.Dash,  IO.None, IO.Out,  IO.In,   IO.Out ));
			//                                                      North    West     East     South
			tileDict.Add(new Point2D(4,6), new Tile(TileType.Blank, IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(3,6), new Tile(TileType.Blank, IO.None, IO.None, IO.In,   IO.Out ));
			tileDict.Add(new Point2D(3,5), new Tile(TileType.Clue,  IO.In,   IO.None, IO.None, IO.Out));
			tileDict.Add(new Point2D(3,4), new Tile(TileType.Blank, IO.In,   IO.Out,  IO.None, IO.None));
			tileDict.Add(new Point2D(2,4), new Tile(TileType.Blank, IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(1,4), new Tile(TileType.Clue,  IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(0,4), new Tile(TileType.Blank, IO.None, IO.None, IO.In,   IO.Out ));
			tileDict.Add(new Point2D(0,3), new Tile(TileType.Blank, IO.In,   IO.None, IO.None, IO.Out));
			//                                                      North    West     East     South
			tileDict.Add(new Point2D(5,5), new Tile(TileType.Haunt, IO.In,   IO.None, IO.None, IO.Out));
			tileDict.Add(new Point2D(5,4), new Tile(TileType.Clue,  IO.In,   IO.None, IO.None, IO.Out));
			tileDict.Add(new Point2D(5,3), new Tile(TileType.Haunt, IO.In,   IO.None, IO.None, IO.Out));
			tileDict.Add(new Point2D(5,2), new Tile(TileType.Dash,  IO.In,   IO.Out,  IO.None, IO.None));
			tileDict.Add(new Point2D(4,2), new Tile(TileType.Haunt, IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(3,2), new Tile(TileType.Clue,  IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(2,2), new Tile(TileType.Haunt, IO.None, IO.Out,  IO.In,   IO.None));
			tileDict.Add(new Point2D(1,2), new Tile(TileType.Clue,  IO.None, IO.Out,  IO.In,   IO.None));
			//                                                      North    West     East     South
			tileDict.Add(new Point2D(0,2), new Tile(TileType.Dash,  IO.In,   IO.None, IO.In,   IO.Out));
			tileDict.Add(new Point2D(0,1), new Tile(TileType.Blank, IO.In,   IO.None, IO.None, IO.Out));
			tileDict.Add(new Point2D(0,0), new Tile(TileType.Dash,  IO.In,   IO.None, IO.Out,  IO.None));
			tileDict.Add(new Point2D(1,0), new Tile(TileType.Blank, IO.None, IO.In,   IO.Out,  IO.None));
			tileDict.Add(new Point2D(2,0), new Tile(TileType.Clue,  IO.None, IO.In,   IO.Out,  IO.None));
			tileDict.Add(new Point2D(3,0), new Tile(TileType.Blank, IO.None, IO.In,   IO.Out,  IO.None));
			tileDict.Add(new Point2D(4,0), new Tile(TileType.Haunt, IO.None, IO.In,   IO.Out,  IO.None));
			tileDict.Add(new Point2D(5,0), new Tile(TileType.Haunt, IO.None, IO.In,   IO.Out,  IO.None));
			tileDict.Add(new Point2D(6,0), new Tile(TileType.Haunt, IO.None, IO.In,   IO.Out,  IO.None));
		}
}
