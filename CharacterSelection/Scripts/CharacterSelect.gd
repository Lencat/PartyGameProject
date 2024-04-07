extends Node2D


func _process(delta):
	match Global.playerSelect:
		0: 
			get_node("PlayerSelect").play("artist")
			get_node("CharacterName").text = "Artist"
		1:
			get_node("PlayerSelect").play("astrologer")
			get_node("CharacterName").text = "Astrologer"
		2:
			get_node("PlayerSelect").play("citizen")
			get_node("CharacterName").text = "Citizen"

func _on_left_pressed():
	if Global.playerSelect > 0:
		Global.playerSelect -= 1
	else:
		Global.playerSelect = 2


func _on_right_pressed():
	if Global.playerSelect < 2:
		Global.playerSelect += 1
	else:
		Global.playerSelect = 0


func _on_select_pressed():
	var playerName = get_node("PlayerName").text
	if playerName == "":
		get_node("NeedName").text = "Need a name"
	else:
		Global.set_player_name(playerName)
		Global.set_character_selection(Global.playerSelect)
		get_tree().change_scene_to_file("res://2DWorld.tscn")
