using Godot;
using System;

namespace Game.PC;

public partial class PlayerCharacter : Node
{
	//private:
		Player player; //linked player
		Character character; //selected character

		//gameplay info
		Point2D position;
		int cluesHeld;
		int cluesBanked;

		int moveMod;
		bool moveReversed;
		bool skipNextTurn;
		/*
		//unused
		int hp = 1;
		*/

	//public:
		public PlayerCharacter()
		{
			this.player = new Player();
			this.character = new Character();

			this.position = new Point2D(0,0);
			this.cluesHeld = 0;
			this.cluesBanked = 0;
			this.moveMod = 0;
			this.moveReversed = false;
			this.skipNextTurn = false;
		}

		public PlayerCharacter(Player player, Character character)
		{
			this.player = player;
			this.character = character;

			this.position = new Point2D(0,0);
			this.cluesHeld = 0;
			this.cluesBanked = 0;
			this.moveMod = 0;
			this.moveReversed = false;
			this.skipNextTurn = false;
		}

		public void setPosition(Point2D point) {this.position = point;}
		public void setPosition(int x, int y) {this.position = new Point2D(x,y);}

		public Point2D getPosition() {return this.position;}
		public int getX() {return this.position.x;}
		public int getY() {return this.position.y;}

		public int getHeldClueCount() {return this.cluesHeld;}
		public int getBankedClueCount() {return this.cluesBanked;}
		public void gainClues(int amount) {this.cluesHeld += amount;}
		public void bankClues() {this.cluesBanked += this.cluesHeld; this.cluesHeld = 0;}
		public int loseClues(int amount)
		{
			int amountLost = Math.Max(cluesHeld, amount);
			cluesHeld -= amount;
			if (cluesHeld < 0) {cluesHeld = 0;}
			return amountLost;
		}

		public bool getMoveReversed() {return this.moveReversed;}
		public void setMoveReversed(bool value) {this.moveReversed = value;}
		public void toggleMoveReversed() {this.moveReversed = !this.moveReversed;}

        public void setSkipNextTurn(bool value) {this.skipNextTurn = value;}
        public bool getSkipNextTurn() {return this.skipNextTurn;}

		public int getMoveMod() {return this.moveMod;}
		public void setMoveMod(int value) {this.moveMod = value;}
		public void changeMoveMod(int value) {this.moveMod += value;}

		public Player getPlayer() {return this.player;}
		public Character getCharacter() {return this.character;}
		public void changePlayer(Player newPlayer) {this.player = newPlayer;}
		public void changeCharacter(Character newCharacter) {this.character = newCharacter;}
}
