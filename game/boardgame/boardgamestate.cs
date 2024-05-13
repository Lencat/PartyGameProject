using Godot;
using System;
using Game.PC;

namespace Game.Board;

public enum PlayerSlot
{
	Player1 = 0,
	Player2 = 1,
	Player3 = 2,
	Player4 = 3
}

public partial class BoardGameState
{
	//private
		PC.PlayerCharacter[] PCs;
		Board board;
		int roundNumber;
		PlayerSlot whoseTurn;
		int[] lastMinigameRankings;

		public void initializePCPositions()
		{
			for(int i=0; i<4; i++)
			{
				PCs[i].setPosition(board.getStartingPoint());
			}
			return;
		}

	//public
		public BoardGameState()
		{
			this.PCs = new PC.PlayerCharacter[4];
			this.board = new Board();
			this.roundNumber = 1;
			this.whoseTurn = PlayerSlot.Player1;
			this.lastMinigameRankings = new int[4];

			this.initializePCPositions();
		}

		public BoardGameState(Board board, PlayerCharacter player1, PlayerCharacter player2, PlayerCharacter player3, PlayerCharacter player4)
		{
			this.PCs = [player1, player2, player3, player4];
			this.board = board;
			this.roundNumber = 1;
			this.whoseTurn = PlayerSlot.Player1;
			this.lastMinigameRankings = new int[4];

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

		public ref Board getBoard() {return ref this.board;}
		public Tile? getTile(Point2D position) {return this.board.getTile(position);}

		public ref PlayerCharacter getPC(PlayerSlot slot) {return ref this.PCs[(int)slot];}
		public ref PlayerCharacter getPC(int slot) {return ref this.PCs[slot];}

		public int getRound() {return this.roundNumber;}
		public PlayerSlot getWhoseTurnSlot() {return this.whoseTurn;}
		public ref PlayerCharacter getWhoseTurnPlayer() {return ref this.PCs[(int)whoseTurn];}

		public void setMinigameResults(int p1rank, int p2rank, int p3rank, int p4rank) {this.lastMinigameRankings = [p1rank, p2rank, p3rank, p4rank];}
		public int[] getMinigameResults() {return this.lastMinigameRankings;}
		public void tempLoadGraveyard() {board.temp_load_map_graveyard();}
}
