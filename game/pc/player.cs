using Godot;
using System;

namespace Game.PC;

public partial class Player : Node
{
	//private:
		string name;
		bool isCPU;

	//public:
		public Player()
		{
			this.name = "Default Player";
			this.isCPU = false;
		}

		public Player(string name, bool isCPU)
		{
			this.name = name;
			this.isCPU = isCPU;
		}

		public Player(string playerFilepath)
		{
			throw new NotImplementedException("Load from file not implemented.");
		}

		public void setName(string new_name) {this.name = new_name;}

		public string getName() {return this.name;}

		public void setCPU(bool value) {this.isCPU = value;}

		public bool getCPU() {return this.isCPU;}
}
