using Godot;
using System;
using Game.Board;
using Game.PC;

namespace Game.Board;

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

public static partial class Display
{
    //private
        static void newRound(ref BoardGameState game)
        {
            game.getRound();
        }
        static void newTurn(ref BoardGameState game)
        {
            game.getWhoseTurnSlot();
        }
        static void turnPrompt(ref BoardGameState game)
        {
            ;
        }
        static void movePrompt(ref BoardGameState game)
        {
            ;
        }
        static void rollPrompt(ref BoardGameState game)
        {
            ;
        }
        static void minigameResults(ref BoardGameState game)
        {
            ;
        }
        static void win(ref BoardGameState game)
        {
            ;
        }
        static void gameResults(ref BoardGameState game)
        {
            PlayerCharacter[] PCs = [
                game.getPC(PlayerSlot.Player1),
                game.getPC(PlayerSlot.Player2),
                game.getPC(PlayerSlot.Player3),
                game.getPC(PlayerSlot.Player4)
            ];

            PCs = PCs.OrderBy(pc => pc.getHeldClueCount()).ToArray();

            int[] placeNumbers = [1, -1, -1, -1];
            for (int i=1; i<4; i++)
            {
                if (PCs[i-1].getHeldClueCount() == PCs[i].getHeldClueCount())
                {
                    placeNumbers[i] = placeNumbers[i-1];
                }
                else
                {
                    placeNumbers[i] = i+1;
                }
            }

            //can now display the info however

            //PCs: array of players ordered by score
            //placeNumbers: array of place rankings for each slot of PCs
            //(if multiple people are tied, they both share the same # ranking)
        }
    //public
        public static void display(ref BoardGameState game, DisplayType type)
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
