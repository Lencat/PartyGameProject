using Godot;
using System;

using Game.Board;
using System.Security.Cryptography;

namespace Game;

public enum TurnAction
{
	EndTurn = -1,
	Nothing =  0,
	Move    =  1
}

public static partial class PlayerInput
{
    public static TurnAction getInputTurnAction(PlayerSlot currentPlayer)
    {
        //TODO: random inputs until I link it proper.
        return (TurnAction)RandomNumberGenerator.GetInt32(-1,2);
    }
}
