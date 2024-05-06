extends Control

# Path to the character selection scene
const CHARACTER_SELECT_SCENE = "res://CharacterSelection/Scenes/CharacterSelect.tscn"

func _on_two_players_pressed():
	Global.init_players(2)
	change_scene()

func _on_three_players_pressed():
	Global.init_players(3)
	change_scene()

func _on_four_players_pressed():
	Global.init_players(4)
	change_scene()

# Change to the character selection scene
func change_scene():
	get_tree().change_scene_to_file(CHARACTER_SELECT_SCENE)
