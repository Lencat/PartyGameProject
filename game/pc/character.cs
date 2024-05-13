using Godot;
using System;

namespace Game.PC;

public partial class Character : Node
{
	//private:
		string name;
		//int characterSprite = 0;

	//public:
		public Character()
		{
			this.name = "Default Character";
		}

		public Character(string characterFilepath)
		{
			throw new NotImplementedException("Load from file not implemented.");
		}

		public void setName(string new_name) {this.name = new_name;}

		public string getName() {return this.name;}
}
