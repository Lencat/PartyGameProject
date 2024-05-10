using Godot;
using System;

[Flags]
public enum Inputs
{
	None       = 0b00000000,
	Confirm    = 0b00000001,
	Cancel     = 0b00000010,
	Move       = 0b00000100,
	Pause      = 0b00001000,
	QuitToMenu = 0b00010000
}

public struct InputTracker
{
	//public
	public Inputs inputs;
	
	public Inputs(Inputs inputs)
	{
		this.inputs = inputs;
	}
	
	public bool inputNone()       {return (this.inputs == Inputs.None             ? true : false);}
	public bool inputConfirm()    {return (this.inputs.HasFlag(Inputs.Confirm)    ? true : false);}
	public bool inputCancel()     {return (this.inputs.HasFlag(Inputs.Cancel)     ? true : false);}
	public bool inputMove()       {return (this.inputs.HasFlag(Inputs.Move)       ? true : false);}
	public bool inputPause()      {return (this.inputs.HasFlag(Inputs.Pause)      ? true : false);}
	public bool inputQuitToMenu() {return (this.inputs.HasFlag(Inputs.QuitToMenu) ? true : false);}
}

public partial class boardgame_ui : CanvasLayer
{
	//current frame's inputs
	public InputTracker currentInputs;
	
	public InputTracker pollInputs()
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		currentInputs = new InputTracker(Inputs.None);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		currentInputs = pollInputs();
	}
}


private void _on_return_to_menu_button_up()
{
	// Replace with function body.
}
