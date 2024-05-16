#unused
extends Node

enum GameState {
	Splash,
	MainMenu,
	BoardGame,
	MiniGame
}

var currentGameState

var pathSplash = "res://splash/splash.tscn"
var pathMainMenu = "res://menu/main/menu_main.tscn"
var pathOptionsMenu = "res://menu/options/menu_options.tscn"
var pathCharacterSelect = "res://characters/CharacterSelect.tscn"
var pathBoardGame = "res://game/data/game_controller.tscn"
var pathGameData = "res://game/data/gamedata.tscn"

func _ready():
	currentGameState = GameState.Splash

func preload_main_menu():
	SceneTransition.preload_scene(pathMainMenu)

func goto_main_menu():
	SceneTransition.switch_scene(pathMainMenu)
	currentGameState = GameState.MainMenu
	
func preload_character_select():
	SceneTransition.preload_scene(pathCharacterSelect)

func goto_character_select():
	SceneTransition.switch_scene(pathCharacterSelect)

func preload_board_game():
	SceneTransition.preload_scene(pathBoardGame)

func goto_board_game():
	SceneTransition.switch_scene(pathBoardGame)
	currentGameState = GameState.BoardGame
