class_name MainMenu
extends Control

@onready var main_menu_buttons = $MarginContainer/VBoxContainer/Buttons
@onready var start_button = $MarginContainer/VBoxContainer/Buttons/Button_Start as Button
@onready var options_button = $MarginContainer/VBoxContainer/Buttons/Button_Options as Button
@onready var exit_button = $MarginContainer/VBoxContainer/Buttons/Button_Exit as Button
@onready var options_menu = $Options

var menuBGM

# Called when the node enters the scene tree for the first time.
func _ready():
	# Prevents options menu from loading in already open / locking open
	initialize_options_menu()
	
	# Allows the menu to be controlled with keyboard
	start_button.grab_focus()
	
	# Plays BGM and stores controller
	menuBGM = MusicManager.play(MusicManager.Music.GothicCuteInst, 0, -10)
	
	#replace with preloading the player/boardgame select when those exist
	Controller.preload_character_select()
	Controller.preload_board_game()

func _on_button_start_pressed() -> void:
	MusicManager.fade_out(menuBGM)
	
	#replace with swapping to the player/boardgame select when those exist
	#Controller.goto_board_game()
	Controller.goto_character_select()

func _on_button_options_pressed() -> void:
	#function for entering the options menu
	main_menu_buttons.set_process(false)
	main_menu_buttons.visible = false
	
	options_menu.set_process(true)
	options_menu.visible = true

func _return_from_options() -> void:
	#function for exiting the options menu
	#hide option menu and make main menu visible
	options_menu.set_process(false)
	options_menu.visible = false
	
	main_menu_buttons.set_process(true)
	main_menu_buttons.visible = true

func _on_button_exit_pressed() -> void:
	#function for exiting the game
	get_tree().quit()

func initialize_options_menu():
	options_menu.visible = false
	options_menu.options_exit.connect(_return_from_options)
