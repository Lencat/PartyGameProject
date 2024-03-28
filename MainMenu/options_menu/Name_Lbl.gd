extends Label

#might not need to be used

@onready var state_lbl = $"../State_Lbl" as Label
@onready var check_button = $"../CheckButton" as CheckButton

func _ready():
	check_button.toggled.connect(on_subtitles_toggled)
	
func set_label_text(button_pressed : bool) -> void:
	if button_pressed != true:
		state_lbl.text = "Off"
	else:
		state_lbl.text = "On"

func on_subtitles_toggled(button_pressed : bool) -> void:
	set_label_text(button_pressed)
	

