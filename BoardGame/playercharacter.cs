using Godot;
using System;

namespace Game.Board;

public partial class Character : Node
{
	private:
		string name;
		//int characterSprite = 0;

	public:
		Character()
		{
			this.name = "Default Character";
		}

		Character(file file_name)
		{
			throw new NotImplementedException("Load from file not implemented.");
		}

		void setName(string new_name) {this.name = new_name;}

		string getName() {return this.name;}
}

public partial class Player : Node
{
	private:
		string name;
		bool isCPU;

	public:
		Player()
		{
			this.name = "Default Player";
			this.isCPU = false;
		}

		Player(string name, bool isCPU)
		{
			this.name = name;
			this.isCPU = isCPU;
		}

		Player(file file_name)
		{
			throw new NotImplementedException("Load from file not implemented.");
		}

		void setName(string new_name) {this.name = new_name;}

		string getName() {return this.name;}

		void setCPU(bool value) {this.isCPU = value;}

		bool getCPU() {return this.isCPU};
}

public partial class PlayerCharacter : Node
{
	private:
		Player player; //linked player
		Character character; //selected character

		//gameplay info
		Point2D position;
		int cluesHeld;
		int cluesBanked;

		/*
		//unused
		int hp = 1;
		int moveMod = 0;
		bool skipNextTurn = false;
		*/

	public:
		PlayerCharacter()
		{
			this.player = Player();
			this.character = Character;

			this.position = Point2D(0,0);
			this.cluesHeld = 0;
			this.cluesBanked = 0;
		}

		PlayerCharacter(Player player, Character character)
		{
			this.player = player;
			this.character = character

			this.position = point2d(0,0);
			this.cluesHeld = 0;
			this.cluesBanked 0;
		}

		void setPosition(Point2D point) {this.position = point;}
		void setPosition(int x, int y) {this.position = Point2D(x,y);}

		Point2D getPosition() {return this.position;}
		int getX() {return this.position.x;}
		int getY() {return this.position.y;}

		void gainClue(int amount = 1) {this.cluesHeld += amount;}
		void bankClues() {this.cluesBanked += this.cluesHeld; this.cluesHeld = 0;}
		int loseClues(int amount)
		{
			int amountLost = max(cluesHeld, amount);
			cluesHeld -= amount;
			if (cluesHeld < 0) {cluesHeld = 0};
			return amountLost;
		}
}
