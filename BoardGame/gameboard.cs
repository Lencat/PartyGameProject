using Godot;
using System;

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

public partial struct Tile : Node
{
	public:
		TileType type = TileType.NoTile;

		// in/out Directions
		int[4] inOutNWES = {IO.None, IO.None, IO.None, IO.None};

		// uninitialized positions
		int x = -1;
		int y = -1;
}

public partial struct TilePath : Node
{
	public:
		Tile currentTile = null;
		TilePath[4] nextTileNWES = {null, null, null, null};
}

public partial class GameBoard : Node
{
	private:
		Tile[][] tileGrid;
		int mapSizeX;
		int mapSizeY;
		int startX;
		int startY;

	public:
		GameBoard() {
			tileGrid = {{}};
			mapSizeX = 0;
			mapSizeY = 0;
			startX = 0;
			startY = 0;
		}

		GameBoard(file mapLayout) {
			throw new NotImplementedException("Load from file not implemented.");
			//store in a json eventually
		}

		void load_map_temp_graveyard() {
			mapSizeX = 8;
			mapSizeY = 7;
			startX = 7;
			startY = 0;
			tileGrid = new Tile[8][7]();

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


public partial struct Character : Node
{
	string name = "Default Character"
	//int characterSprite = 0;
}

public partial struct Player : Node
{
	string name = "Default Player";
}

public partial struct PlayerCharacter : Node
{
	Player player = Player();
	Character character = Character();
	bool isCPU = false;

	//gameplay info
	int x = 0;
	int y = 0;
	int cluesHeld = 0;
	int cluesBanked = 0;

	/*
	//unused
	int hp = 1;
	int moveMod = 0;
	bool skipNextTurn = false;
	*/
}

public partial struct Gamestate : Node
{
	PlayerCharacter[4] PCs;
	int roundNumber = 0;
	int whoseTurn = 0;
}

enum GameAction
{
	EndTurn = -1;
	Nothing =  0;
	Move    =  1;
}

public partial class Gameplay : Node
{
	private:
		int[] rollDice (int diceCount)
		{
			result = int[diceCount];
			for (int i=0; i<diceCount; i++)
			{
				result[i] = RandomNumberGenerator.GetInt32(1, 6);
			}
			return result;
		}

		void move(PlayerCharacter pc, int diceCount = 1, int moveMod = 0, bool reverse = false)
		{
			//TODO: rewrite to tie in with actual dice function
			int move_distance = sum(rollDice(diceCount)) + moveMod + pc.moveMod;

			TilePath paths = calculatePaths(pc.x, pc.y, move_distance, xor(pc.moveReversed, reverse));

			while (paths is not null)
			{
				//move character to current step of path
				renderMoveCharacter(pc, paths.currentTile.x, paths.currentTile.y);

				//determine next step
				bool directionValid[4] = {
					paths[Direction.North] is not null,
					paths[Direction.West] is not null,
					paths[Direction.East] is not null,
					paths[Direction.South] is not null
				}
				int directionCount = sum(directionValid[direction.North], directionValid[direction.West], directionValid[direction.East], directionValid[direction.South];

				if (directionCount == 0)
				{
					paths = null;
				}
				else if (directionCount == 1)
				{
					if (directionValid[Direction.North]) {paths = paths.nextTileNWES[Direction.North]};
					else if (directionValid[Direction.West]) {paths = paths.nextTileNWES[Direction.West]};
					else if (directionValid[Direction.East]) {paths = paths.nextTileNWES[Direction.East]};
					else if (directionValid[Direction.South]) {paths = paths.nextTileNWES[Direction.South]};
				}
				else if (directionCount > 1)
				{
					paths = paths.nextTileNWES[promptMoveDirection(directionValid)];
				}
			}

		TilePath promptMoveDirection(bool[4] validDirections)
		{
			if (validDirections[Direction.North]) {/*render button north*/};
			if (validDirections[Direction.West])  {/*render button west */};
			if (validDirections[Direction.East])  {/*render button east */};
			if (validDirections[Direction.South]) {/*render button south*/};

			int chosenDirection = -1;
			while (or(chosenDirection == -1, validDirections[chosenDirection] == false)
			{
				//replace with proper prompt eventually
				RandomNumberGenerator.GetInt32(0, 3);
			}
			return direction;
		}

		TilePath calculatePaths(int currentX, int currentY, int distance, bool reverse = false, int depth = 0)
		{
			//check if there's still distance left to travel, if the anti-infinite-loop limit has been reached, and if current tile is within gameboard bounds
			if or(distance < 0, depth > 100, currentX < 0, currentX >= maxpSizeX, currentY < 0, mapSize >= mapSizeY)
			{
				return void;
			}

			/* Unneccesary
				//check if current tile exists
				if not(tileGrid[currentX][currentY] is tile)
				{
					throw new Exception("Current tile is invalid: x = " + str(currentX) + ", y = " + str(currentY));
				}
			*/

			//create current tilepath
			TilePath output = new TilePath;
			output.currentTile = tileGrid[currentX][currentY];

			//check if current tile is nonexistant, if so don't return a path / extend recursive path
			if (output.currentTile.type == NoTile)
				return void;

			//if current tile is slippery, increase distance to account for it
			if(output.currentTile.type == TileType.Slippery)
			   distance++;

			//continue search along potential outs
			if (output.currentTile.inOutNWES[Direction.North] == xor(IO.Out, reverse))
				output.nextTileNWES[Direction.North] = calculatePaths(currentX, currentY+1, distance-1, reverse, depth+1);

			if (output.currentTile.inOutNWES[Direction.West] == xor(IO.Out, reverse))
				output.nextTileNWES[Direction.West] = calculatePaths(currentX-1, currentY, distance-1, reverse, depth+1);

			if (output.currentTile.inOutNWES[Direction.East] == xor(IO.Out, reverse))
				output.nextTileNWES[Direction.East] = calculatePaths(currentX+1, currentY, distance-1, reverse, depth+1);

			if (output.currentTile.inOutNWES[Direction.South] == xor(IO.Out, reverse))
				output.nextTileNWES[Direction.South] = calculatePaths(currentX, currentY-1, distance-1, reverse, depth+1);

			//all done
			return output;
		}

	public:
		void mainLoop()
		{
			bool continueGame = true;
			Gamestate game;

			//test defaults
			game.PCs[0].player.name = "Player 1";
			game.PCs[1].player.name = "Player 2";
			game.PCs[2].player.name = "Player 3";
			game.PCs[3].player.name = "Player 4";

			//set characters to starting location

			//game loop
			while (continueGame)
			{
				//round loop
				game.roundNumber++;
				renderNextRound(game.roundNumber);

				game.whoseTurn = 0;

				//start of round actions
				;

				//turn loops
				while (whoseTurn < 4)
				{
					//start of turn actions
					bool continueTurn = true;
					bool hasMoved = false;

					//inter-turn loop
					while (continueTurn)
					{
						int playerAction = getPlayerInput(game.PCs[whoseTurn]);
						select playerAction
						{
							case GameAction.Nothing:
								sleep(100);
								break;
							case GameAction.Move:
								if (hasMoved == true) {break;}
								move(game.PCs[whoseTurn]);
								hasMoved = false;
								break;
							case GameAction.EndTurn:
								continueTurn = false;
								break;
						}
					}

					//end of turn actions
				}

				//end of round actions
				;
			}
		}
}
