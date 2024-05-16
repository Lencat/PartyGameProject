extends Control

var playerSelectNode: AnimatedSprite2D
var characterNameLabel: Label
var playerNameInput: LineEdit
var needNameLabel: Label
var playerNumberLabel: Label

func _ready():
	playerSelectNode = get_node("PlayerSelect") as AnimatedSprite2D
	characterNameLabel = get_node("CharacterName") as Label
	playerNameInput = get_node("PlayerName") as LineEdit
	needNameLabel = get_node("NeedName") as Label
	playerNumberLabel = get_node("MarginContainer/PlayerNumber") as Label
	reset_for_next_player()

func reset_for_next_player():
	playerNameInput.text = ""
	needNameLabel.text = ""
	update_display()  # Ensure initial display is updated including sprite animation

func update_display():
	var character_index = CharacterData.players_info[CharacterData.get_current_player()]["character"]
	characterNameLabel.text = ["Artist", "Astrologer", "Citizen"][character_index]
	playerSelectNode.play(["artist", "astrologer", "citizen"][character_index])
	playerNumberLabel.text = "Player "+str(CharacterData.get_current_player()+1)

func _on_left_pressed():
	var current_selection = CharacterData.players_info[CharacterData.get_current_player()]["character"]
	current_selection = (current_selection - 1 + 3) % 3
	CharacterData.set_character_selection(current_selection, CharacterData.get_current_player())
	update_display()

func _on_right_pressed():
	var current_selection = CharacterData.players_info[CharacterData.get_current_player()]["character"]
	current_selection = (current_selection + 1) % 3
	CharacterData.set_character_selection(current_selection, CharacterData.get_current_player())
	update_display()

func _on_select_pressed():
	var playerName = playerNameInput.text
	var currentPlayerIndex = CharacterData.get_current_player()  # Get the current player's index

	if playerName == "" or CharacterData.players_info[CharacterData.get_current_player()]["character"] == null:
		needNameLabel.text = "Please enter a name"
	else:
		CharacterData.set_player_name(playerName, CharacterData.get_current_player())
		# Print the current player's index along with the name after it's set
		print("Player ", currentPlayerIndex + 1, " Selected Name: ", playerName) 
		if not CharacterData.next_player():
			if CharacterData.all_players_ready():
				Controller.goto_board_game()
			else:
				reset_for_next_player()
		else:
			reset_for_next_player()  # Reset for the next player even if it's not the last one
