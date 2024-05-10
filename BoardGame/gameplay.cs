using Godot;
using System;

namespace Game.Board;

public enum PlayerSlot
{
	Player1 = 0,
	Player2 = 1,
	Player3 = 2,
	Player4 = 3
}

public partial class GameState
{
	//private
		PlayerCharacter[] PCs;
		GameBoard board;
		int roundNumber;
		PlayerSlot whoseTurn;

		public void initializePCPositions()
		{
			for(int i=0; i<4; i++)
			{
				PCs[i].setPosition(board.getStartingPoint());
			}
			return;
		}

	//public
		public GameState()
		{
			this.PCs = new PlayerCharacter[4];
			this.board = new GameBoard();
			this.roundNumber = 1;
			this.whoseTurn = PlayerSlot.Player1;

			this.initializePCPositions();
		}

		public GameState(GameBoard board, PlayerCharacter player1, PlayerCharacter player2, PlayerCharacter player3, PlayerCharacter player4)
		{
			this.PCs = [player1, player2, player3, player4];
			this.board = board;
			this.roundNumber = 1;
			this.whoseTurn = PlayerSlot.Player1;

			this.initializePCPositions();
		}

		public void nextTurn()
		{
			if (this.whoseTurn != PlayerSlot.Player4)
			{
				this.whoseTurn++;
			}
			else
			{
				this.roundNumber++;
				this.whoseTurn = PlayerSlot.Player1;
			}
			return;
		}

		public bool isGameWon() {
			for(int i=0; i<4; i++)
			{
				if (PCs[i].getHeldClueCount() >= 10)
				{
					return true;
				}
			}
			return false;
		}

		public ref GameBoard getBoard() {return ref this.board;}
		public Tile? getTile(Point2D position) {return this.board.getTile(position);}
		public PlayerSlot getWhoseTurnSlot() {return this.whoseTurn;}
		public ref PlayerCharacter getWhoseTurnPlayer() {return ref this.PCs[(int)whoseTurn];}
		public int getRound() {return this.roundNumber;}

		public ref PlayerCharacter getPC(PlayerSlot slot) {return ref this.PCs[(int)slot];}

		public void tempLoadGraveyard() {board.temp_load_map_graveyard();}
}

public static partial class Gameplay
{
	//public:
		public static void mainLoop()
		{
			bool continueGame = true;

			//initialize game state
			GameState game = new GameState(
				new GameBoard(),                                                     //selectBoard(),
				new PlayerCharacter(new Player("Player 1", false), new Character()), //selectPlayer(PlayerSlot.Player1),
				new PlayerCharacter(new Player("Player 2", false), new Character()), //selectPlayer(PlayerSlot.Player2),
				new PlayerCharacter(new Player("Player 3", false), new Character()), //selectPlayer(PlayerSlot.Player3),
				new PlayerCharacter(new Player("Player 4", false), new Character())  //selectPlayer(PlayerSlot.Player4)
			);
			
			//TODO, replace when we can load from file
			game.tempLoadGraveyard();
			
			//game loop
			while (continueGame)
			{
				//handle new round
				if(game.getWhoseTurnSlot() == PlayerSlot.Player1)
				{
					GameDisplay.display(ref game, DisplayType.NewRound);
				}

				//handle start of turn
				GameDisplay.display(ref game, DisplayType.NewTurn);
				bool continueTurn = true;
				bool hasMoved = false;

				//handle turn loop
				while (continueTurn)
				{
					GameDisplay.display(ref game, DisplayType.TurnPrompt);
					TurnAction playerAction = PlayerInput.getInputTurnAction(ref game, game.getWhoseTurnSlot());
					switch (playerAction)
					{
						case TurnAction.Nothing:
							break;
						case TurnAction.Move:
							if (hasMoved == true) {break;}
							BoardMovement.move(ref game, ref game.getWhoseTurnPlayer());
							TileEffect.triggerTile(ref game, ref game.getWhoseTurnPlayer(), game.getTile(game.getWhoseTurnPlayer().getPosition()));
							hasMoved = true;
							break;
						case TurnAction.EndTurn:
							continueTurn = false;
							break;
					}
				}

				//handle end of turn
				;

				//win check
				if (game.isGameWon())
				{
					continueGame = false;
				}

				//handle end of round
				else if(game.getWhoseTurnSlot() == PlayerSlot.Player1)
				{
					;
				}
			}

			//handle win
			GameDisplay.display(ref game, DisplayType.Win);
			GameDisplay.display(ref game, DisplayType.GameResults);
		}
}
