extends Node2D


func _ready():
	var playerName = Global.playerName
	print("Welcome " + playerName + "!")
	
	get_player_character()

func get_player_character():
	var selected_scene = Global.character_scenes[Global.playerSelect]
	
	if selected_scene:
		var character_instance = selected_scene.instantiate()
		add_child(character_instance)
		# character_instance.position = Vector2(100, 100)
		
