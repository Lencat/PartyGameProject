extends MarginContainer

@onready var gui = $".."

func _ready():
	visible = false

func _on_button_roll_pressed():
	gui.hide_move_prompt()
	gui.s_roll.emit()

func _on_button_back_pressed():
	gui.hide_move_prompt()
	gui.show_turn_prompt()
