using Game.Board;
using Godot;
using System;

namespace Game;

public partial class Data : Node
{
	//singleton setup
	private static Lazy<Data> lazy = new Lazy<Data>(() => new Data());

	public static Data Instance {get {return lazy.Value;}}

	//actual info
	private GameState currentGameState;
	private BoardGameState currentBoardGameState;

	private Data() {
		currentGameState = GameState.MainMenu;
		currentBoardGameState = new BoardGameState();
	}

	public void setGameState(GameState state) {this.currentGameState = state;}
	public GameState getGameState() {return this.currentGameState;}

	public void setBoardGameState(Board.BoardGameState state) {this.currentBoardGameState = state;}
	public ref Board.BoardGameState getBoardGameState() {return ref this.currentBoardGameState;}
}

public enum GameState
{
	MainMenu,
	BoardGame,
	MiniGame
}
