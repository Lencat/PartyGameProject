using Godot;
using System;
using Game.Board;

namespace Game;

public enum DisplayType
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

public static partial class GameDisplay
{
    //private
        static void newRound(ref GameState game)
        {
            game.getRound();
        }
        static void newTurn(ref GameState game)
        {
            game.getWhoseTurnSlot();
        }
        static void turnPrompt(ref GameState game)
        {
            ;
        }
        static void movePrompt(ref GameState game)
        {
            ;
        }
        static void rollPrompt(ref GameState game)
        {
            ;
        }
        static void minigameResults(ref GameState game)
        {
            ;
        }
        static void win(ref GameState game)
        {
            ;
        }
        static void gameResults(ref GameState game)
        {
            PlayerCharacter[] PCs = [
                game.getPC(PlayerSlot.Player1),
                game.getPC(PlayerSlot.Player2),
                game.getPC(PlayerSlot.Player3),
                game.getPC(PlayerSlot.Player4)
            ];
        }
    //public
        public static void display(ref GameState game, DisplayType type)
        {
            switch (type)
            {
                case DisplayType.Nothing:
                    break;
                case DisplayType.NewRound:
                    newRound(ref game);
                    break;
                case DisplayType.NewTurn:
                    newTurn(ref game);
                    break;
                case DisplayType.TurnPrompt:
                    turnPrompt(ref game);
                    break;
                case DisplayType.MovePrompt:
                    movePrompt(ref game);
                    break;
                case DisplayType.RollPrompt:
                    rollPrompt(ref game);
                    break;
                case DisplayType.MinigameResults:
                    minigameResults(ref game);
                    break;
                case DisplayType.Win:
                    win(ref game);
                    break;
                case DisplayType.GameResults:
                    gameResults(ref game);
                    break;
            }
        }
}
