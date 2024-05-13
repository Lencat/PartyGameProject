using Godot;
using System;

namespace Game.Board;

public enum TileType {
	Blank, //can visit but nothing happens
	Home, //can turn in clues to secure them
	Clue, //beneficial minigame
	Haunt, //dangerous minigame
	Dash, //extra move if you stop here
	Slippery, //slide past tile even if you don't stop on it
	Pitfall, //tile moves you to an adjacent tile you couldn't normally move to if you stop on it
	Reverse //reverses your direction of travel if you stop on it
}

public enum Direction {
	North = 0,
	West  = 1,
	East  = 2,
	South = 3
}

public enum IO {
	None = -1,
	In   =  0,
	Out  =  1
}

public partial class Tile
{
	//private:
		TileType type;
		IO[] inOutNWES; //default in/out Directions; always should be size 4
		Point2D position; //used as a backreference-- dictionary position should take priority

	//public:
		public Tile(TileType type, IO north, IO west, IO east, IO south)
		{
			this.type = type;
			this.position = new Point2D(-1,-1);
			this.inOutNWES = new IO[4];
			this.inOutNWES[(int)Direction.North] = north;
			this.inOutNWES[(int)Direction.West]  = west;
			this.inOutNWES[(int)Direction.East]  = east;
			this.inOutNWES[(int)Direction.South] = south;
		}

		public void setPosition(Point2D position) {this.position = position;}
		public void setPosition(int x, int y) {this.position = new Point2D(x,y);}
		
		public Point2D getPosition() {return this.position;}
		public int getX() {return this.position.x;}
		public int getY() {return this.position.y;}

		public void setInOut(Direction direction, IO inOut)
		{
			this.inOutNWES[(int)direction] = inOut;
		}
		public void setInOutAll(IO north, IO west, IO east, IO south)
		{
			this.inOutNWES[(int)Direction.North] = north;
			this.inOutNWES[(int)Direction.West] = west;
			this.inOutNWES[(int)Direction.East] = east;
			this.inOutNWES[(int)Direction.South] = south;
		}
		public IO getInOut(Direction direction) {return this.inOutNWES[(int)direction];}

		public void setType (TileType type) {this.type = type;}
		public TileType getType () {return this.type;}
}
