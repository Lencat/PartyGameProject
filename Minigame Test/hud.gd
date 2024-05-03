extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


# Called when the node enters the scene tree for the first time.
func _ready():
	$ReturnButton.hide()
	$StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$StartButton.hide()
	$Instructions.hide()
	$Controls.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()


func end_game():
	$ReturnButton.show()
	$ReturnButton.grab_focus()


func _on_return_pressed():
	get_tree().quit()
