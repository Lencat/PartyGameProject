class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button as Button
@onready var options_menu = $Options_Menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer

@onready var start_level = preload("res://2DWorld.tscn") as PackedScene #insert main scene


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/HBoxContainer/VBoxContainer/Start_Button.grab_focus() 
	#allows the menu to be controlled with keyboard
	handle_connecting_signals()
	
func _on_start_button_pressed() -> void:
	#function for starting the game, loads up the 1st scene
	
	get_tree().change_scene_to_packed(start_level) #Paste 1st scene
	pass
	
func _on_options_button_pressed() -> void:
	#function for entering the options menu
	
	margin_container.visible = false
	options_menu.set_process(true) #allows interaction with options menu buttons
	options_menu.visible = true
	
func _on_exit_button_pressed() -> void:
	#function for exiting the game
	
	get_tree().quit()
	
func _on_exit_options_menu() -> void:
	#function for exiting the options menu
	#hide option menu and make main menu visible
	
	margin_container.visible = true
	options_menu.visible = false

func handle_connecting_signals() -> void:
	start_button.button_down.connect(_on_start_button_pressed)
	options_button.button_down.connect(_on_options_button_pressed)
	exit_button.button_down.connect(_on_exit_button_pressed)
	options_menu.exit_options_menu.connect(_on_exit_options_menu)



