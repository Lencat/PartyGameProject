extends MarginContainer

@onready var switch_button = $HBoxContainer/CheckButton as CheckButton
@onready var label_state = $HBoxContainer/State as Label

func _ready():
	#TODO replace with load from file
	pass

func _on_check_button_pressed():
	switch_button.toggle_mode = !switch_button.toggle_mode
	#set option toggled
	if switch_button.toggle_mode == true:
		label_state.text = "On"
		#TODO put other variable setting stuff here
	else:
		label_state.text = "Off"
		#TODO put other variable setting stuff here
