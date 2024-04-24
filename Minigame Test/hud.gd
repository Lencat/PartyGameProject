extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("All Players Done")
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
