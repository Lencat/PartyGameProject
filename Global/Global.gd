extends Node


var playerName: String = ""
var playerSelect = 0

var character_scenes = {
	0: preload("res://2DCharacters/Scenes/Artist.tscn"),
	1: preload("res://2DCharacters/Scenes/Astrologer.tscn"),
	2: preload("res://2DCharacters/Scenes/Citizen.tscn")
}

func set_character_selection(index: int):
	playerSelect = index
	
func set_player_name(name: String):
	playerName = name
	
