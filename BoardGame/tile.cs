using Godot;
using System;

namespace Game.Board;

enum TileType {
	NoTile, //can't visit
	Blank, //can visit but nothing happens
	Home, //can turn in clues to secure them
	Clue, //beneficial minigame
	Haunt, //dangerous minigame
	Dash, //extra move if you stop here
	Slippery, //slide past tile even if you don't stop on it
	Pitfall, //tile moves you to an adjacent tile you couldn't normally move to if you stop on it
	Reverse //reverses your direction of travel if you stop on it
}

enum Direction {
	North = 0,
	West  = 1,
	East  = 2,
	South = 3
}

enum IO {
	None = -1,
	In   =  0,
	Out  =  1
}

public partial class Tile : Node
{
	private:
		TileType type;
		IO[4] inOutNWES; // default in/out Directions
		Point2D position;

    public:
        Tile(TileType type, Point2D position, IO north, IO west, IO east, IO south)
        {
            this.type = type;
            this.position = position;
            this.inOutNWES[Direction.North] = north;
            this.inOutNWES[Direction.West] = west;
            this.inOutNWES[Direction.East] = east;
            this.inOutNWES[Direction.South] = south;
        }

        void setPosition(Point2D position) {this.position = position;}
        void setPosition(int x, int y) {this.position = Point2D(x,y);}
        
        Point2D getPosition() {return this.position;}
        int getX() {return this.position.x();}
        int getY() {return this.position.y;}

        void setInOut(Direction direction, IO inOut)
        {
            this.inOutNWES[direction] = inOut;
        }
        void setInOutAll(IO north, IO west, IO east, IO south)
        {
            this.inOutNWES[Direction.North] = north;
            this.inOutNWES[Direction.West] = west;
            this.inOutNWES[Direction.East] = east;
            this.inOutNWES[Direction.South] = south;
        }
        IO getInOut(Direction direction) {return this.inOutNWES[direction];}

        void setType (TileType type) {this.type = type;}
        TileType getType () {return this.type;}
}
