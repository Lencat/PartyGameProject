extends Node

# Constants for the character scenes
const ARTIST_SCENE = preload("res://characters/artist/artist.tscn")
const ASTROLOGER_SCENE = preload("res://characters/astrologist/astrologist.tscn")
const CITIZEN_SCENE = preload("res://characters/citizen/citizen.tscn")

var characters = [ARTIST_SCENE, ASTROLOGER_SCENE, CITIZEN_SCENE]

# Store player information and current player index
var players_info = []
var current_player_index = 0

func _ready():
	init_players(4)

# Initialize the players with empty data
func init_players(count: int) -> void:
	players_info = []
	for i in range(count):
		players_info.append({"name": "", "character": 0})

# Set the player's name for the current index
func set_player_name(name: String, index: int) -> void:
	if index < players_info.size():
		players_info[index]["name"] = name

# Set the character selection based on the player's choice
func set_character_selection(selection: int, index: int) -> void:
	if index < players_info.size():
		players_info[index]["character"] = selection

# Check if all players have made their selections
func all_players_ready() -> bool:
	for info in players_info:
		if info["name"] == "" or info["character"] == null:
			return false
	return true
	
# Check if a specific player has completed their setup
func is_player_ready(index: int) -> bool:
	if index < players_info.size():
		return players_info[index]["name"] != "" and players_info[index]["character"] != null
	return false

# Move to the next player for selection
func next_player() -> bool:
	current_player_index += 1
	if current_player_index >= players_info.size():
		current_player_index = 0  # Optionally reset or handle the end of selections differently
		return false
	return true

# Retrieve the current player's index for selection
func get_current_player() -> int:
	return current_player_index
