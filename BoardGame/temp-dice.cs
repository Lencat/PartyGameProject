using Godot;
using System;
using System.Security.Cryptography;

namespace Game;

public static partial class Dice
{
    public static int[] rollDice (int diceCount)
	{
		int[] result = new int[diceCount];
		for (int i=0; i<diceCount; i++)
		{
			result[i] = RandomNumberGenerator.GetInt32(1, 7);
		}
		return result;
	}
}
