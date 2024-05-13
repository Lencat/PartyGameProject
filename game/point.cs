//using Godot;
using System;

namespace Game;

public partial struct Point2D //: Node
{
	public int x;
	public int y;

	public Point2D()
	{
		this.x = 0;
		this.y = 0;
	}
		
	public Point2D(int x, int y)
	{
		this.x = x;
		this.y = y;
	}
};

public partial struct Point3D //: Node
{
	//public:
		public int x;
		public int y;
		public int z;
	
		public Point3D()
		{
			this.x = 0;
			this.y = 0;
			this.z = 0;
		}
		
		public Point3D(int x, int y, int z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
};
