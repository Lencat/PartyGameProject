using Godot;
using System;

using Game.PC;

namespace Game.Board;

public static partial class TileEffect
{
    //private
        //
    //public
        public static void triggerTile(ref BoardGameState game, ref PC.PlayerCharacter pc, Tile? tile)
        {
            if (tile is null)
            {
                //if a player somehow ends up nowhere, reset them to the start.
                pc.setPosition(game.getBoard().getStartingPoint());
                return;
            }
            switch (tile.getType())
            {
                case TileType.Blank:
                    break;
                case TileType.Home:
                    pc.bankClues();
                    break;
                case TileType.Clue:
                    pc.gainClues(1);
                    break;
                case TileType.Haunt:
                    scene_switcher.Call("switch_scene", "res://game/minigame/river.tscn");
                    //Minigame.Call("startMinigame", ref game);
                    break;
                case TileType.Dash:
                    BoardMovement.move(ref game, ref pc);
                    break;
                case TileType.Slippery:
                    //slipping handled as part of movement code
                    //nothing special if you somehow land on one directly though
                    break;
                case TileType.Pitfall:
                    //TODO
                    break;
                case TileType.Reverse:
                    pc.toggleMoveReversed();
                    break;
                default:
                    //unsupported tile type? should never get here
                    break;
            }
        }
}
