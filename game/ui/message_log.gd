extends ScrollContainer

@onready var log_box = $log_box

var messages = []

func log_message(message : String):
	var new_label = Label.new()
	new_label.text = message
	messages.insert(0,new_label)
	log_box.add_child(new_label)
	new_label.grab_focus()
	get_tree().create_timer(60).timeout.connect(pop_oldest)

func pop_oldest():
	pass
	#messages.front().free()
