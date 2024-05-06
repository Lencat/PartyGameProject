extends Control

var playerSelectNode: AnimatedSprite2D
var characterNameLabel: Label
var playerNameInput: LineEdit
var needNameLabel: Label

func _ready():
	playerSelectNode = get_node("PlayerSelect") as AnimatedSprite2D
	characterNameLabel = get_node("CharacterName") as Label
	playerNameInput = get_node("PlayerName") as LineEdit
	needNameLabel = get_node("NeedName") as Label
	reset_for_next_player()

func reset_for_next_player():
	playerNameInput.text = ""
	needNameLabel.text = ""
	update_display()  # Ensure initial display is updated including sprite animation

func update_display():
	var character_index = Global.players_info[Global.get_current_player()]["character"]
	characterNameLabel.text = ["Artist", "Astrologer", "Citizen"][character_index]
	playerSelectNode.play(["artist", "astrologer", "citizen"][character_index])

func _on_left_pressed():
	var current_selection = Global.players_info[Global.get_current_player()]["character"]
	current_selection = (current_selection - 1 + 3) % 3
	Global.set_character_selection(current_selection, Global.get_current_player())
	update_display()

func _on_right_pressed():
	var current_selection = Global.players_info[Global.get_current_player()]["character"]
	current_selection = (current_selection + 1) % 3
	Global.set_character_selection(current_selection, Global.get_current_player())
	update_display()

func _on_select_pressed():
	var playerName = playerNameInput.text
	var currentPlayerIndex = Global.get_current_player()  # Get the current player's index

	if playerName == "" or Global.players_info[Global.get_current_player()]["character"] == null:
		needNameLabel.text = "Please enter a name"
	else:
		Global.set_player_name(playerName, Global.get_current_player())
		# Print the current player's index along with the name after it's set
		print("Player ", currentPlayerIndex + 1, " Selected Name: ", playerName) 
		if not Global.next_player():
			if Global.all_players_ready():
				get_tree().change_scene_to_file("res://2DWorld.tscn")
			else:
				reset_for_next_player()
		else:
			reset_for_next_player()  # Reset for the next player even if it's not the last one
