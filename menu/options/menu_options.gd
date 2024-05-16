extends Control

signal options_exit

func _on_button_exit_pressed():
	options_exit.emit()
