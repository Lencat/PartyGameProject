using Godot;
using System;

using System.Security.Cryptography;

namespace Game.Board;

public enum TurnAction
{
	EndTurn = -1,
	Nothing =  0,
	Move    =  1
}

public static partial class Input
{
    public static TurnAction getInputTurnAction(ref BoardGameState game, PlayerSlot currentPlayer)
    {
        //TODO: random inputs until I link it proper.
        return (TurnAction)RandomNumberGenerator.GetInt32(-1,2);
    }

    public static Direction getInputMoveDirection(ref BoardGameState game, bool[] validDirections)
    {
        if (validDirections[(int)Direction.North]) {/*render button north*/};
        if (validDirections[(int)Direction.West])  {/*render button west */};
        if (validDirections[(int)Direction.East])  {/*render button east */};
        if (validDirections[(int)Direction.South]) {/*render button south*/};

        Direction? chosenDirection = null;
        while (chosenDirection is not null & validDirections[(int)chosenDirection] == false)
        {
            //TODO: replace with proper prompt eventually
            RandomNumberGenerator.GetInt32(0, 3);
        }
        return (Direction)chosenDirection;
    }
}
