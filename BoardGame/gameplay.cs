using Godot;
using System;

namespace Game.Board;

public partial struct GameState : Node
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

enum GameDisplay
{
	Nothing,
	NewRound,
	NewTurn,
	TurnPrompt,
	MovePrompt,
	RollPrompt,
	MinigameResults,
	Win,
	GameResults
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
				renderMoveCharacter(pc, paths.currentTile.x, paths.currentTile.y); //TODO

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
				return null;
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
				return null;

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
			game.board.temp_load_map_graveyard();

			//set characters to starting location
			for (int i=0; i<4; i++)
			{
				game.PCs[i].x = game.board.startX;
				game.PCs[i].y = game.board.startY;
			}
			
			//game loop
			while (continueGame)
			{
				//round loop
				game.roundNumber++;
				display(GameDisplay.NewRound, const &game);

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
								triggerTile(game.PCs[whoseTurn]);
								hasMoved = true;
								break;
							case GameAction.EndTurn:
								continueTurn = false;
								break;
						}
					}
					//end of turn actions
					
					//win condition
					if(game.PCs[whoseTurn].cluesHeld >= 10)
					{
						display()
						continueGame = false;
					}
				}
				//end of round actions
			}
		}
}
