using Godot;
using System;
using Game.PC;

namespace Game.Board;

public static partial class Boardgame
{
	//public:
		//start new game
		public static void newGame()
		{
			Data.Instance.setBoardGameState
			(
				new BoardGameState
				(
					new Board(),                                                         //selectBoard(),
					new PlayerCharacter(new Player("Player 1", false), new Character()), //selectPlayer(PlayerSlot.Player1),
					new PlayerCharacter(new Player("Player 2", false), new Character()), //selectPlayer(PlayerSlot.Player2),
					new PlayerCharacter(new Player("Player 3", false), new Character()), //selectPlayer(PlayerSlot.Player3),
					new PlayerCharacter(new Player("Player 4", false), new Character())  //selectPlayer(PlayerSlot.Player4)
				)
			);

			//tempoarary
			Data.Instance.getBoardGameState().tempLoadGraveyard();

			//start
			gameLoop(ref Data.Instance.getBoardGameState());
		}

		//continue existing game
		public static void gameLoop(ref BoardGameState game, bool display = true)
		{
			bool continueGame = true;

			//game loop
			while (continueGame)
			{
				//handle new round
				if(game.getWhoseTurnSlot() == PlayerSlot.Player1)
				{
					Game.Board.Display.display(ref game, DisplayType.NewRound);
				}

				//handle start of turn
				if (display) Game.Board.Display.display(ref game, DisplayType.NewTurn);
				bool continueTurn = true;
				bool hasMoved = false;

				//handle turn loop
				while (continueTurn)
				{
					if (display) Game.Board.Display.display(ref game, DisplayType.TurnPrompt);
					TurnAction playerAction = Game.Board.Input.getInputTurnAction(ref game, game.getWhoseTurnSlot());
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

				//win check
				if (game.isGameWon())
				{
					break;
				}

				//handle end of turn
				;
				
				//handle end of round
				if(game.getWhoseTurnSlot() == PlayerSlot.Player4)
				{
					;
				}

				game.nextTurn();
			}

			if (game.isGameWon())
			{
				//handle win
				if (display) Game.Board.Display.display(ref game, DisplayType.Win);
				if (display) Game.Board.Display.display(ref game, DisplayType.GameResults);
			}
			//else game quit early
			;
		}
}
