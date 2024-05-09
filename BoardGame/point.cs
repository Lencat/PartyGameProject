using Godot;
using System;

namespace Game;

public partial struct Point2D : Node
{
	public:
		int x;
		int y;
        
		Point2D()
		{
			this.x = 0;
			this.y = 0;
		}
		
		Point2D(int x, int y)
		{
			this.x = x;
			this.y = y;
		}
};

public partial struct Point3D : Node
{
	public:
		int x;
		int y;
        int z;
	
		Point3D()
		{
			this.x = 0;
			this.y = 0;
            this.z = 0;
		}
		
		Point2D(int x, int y, int z)
		{
			this.x = x;
			this.y = y;
            this.z = z;
		}
};
