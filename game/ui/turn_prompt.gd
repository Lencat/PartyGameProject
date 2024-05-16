extends MarginContainer

@onready var gui = $".."

func _ready():
	visible = false

func _on_button_move_pressed():
	gui.hide_turn_prompt()
	gui.show_move_prompt()

func _on_button_end_turn_pressed():
	gui.hide_turn_prompt()
	gui.s_end_turn.emit()
