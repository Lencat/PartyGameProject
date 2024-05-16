extends MarginContainer

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = "move_right"

#NEED TO IMPLEMENT WAY TO SAVE KEYBINDS
#OTHERWISE WILL NEED TO REBIND EVERY LAUNCH

func _ready():
	set_process_unhandled_key_input(false) #ignore accidental rebinds
	set_action_name()
	set_text_for_key()
	
func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		#changes the label name to match the text
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"jump":
			label.text = "Jump"
			
func set_text_for_key() -> void:
	#function for setting a new key for an action
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode
	

func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key..."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				#prevent other buttons from being toggled if 1 is already selected
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
			
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				#allow other buttons to be togglable
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()
		
func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false
	
func rebind_action_key(event) -> void:
	var is_duplicate=false
	var action_event=event
	var action_keycode=OS.get_keycode_string(action_event.physical_keycode)

	#check if hotkey is already assigned
	for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name!=self.action_name:
				if i.button.text=="%s" %action_keycode:
					is_duplicate=true
					break

	if not is_duplicate:
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name,event)
		set_process_unhandled_key_input(false)
		set_text_for_key()
		set_action_name()
