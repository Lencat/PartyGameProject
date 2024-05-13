extends Node

enum GameState
{
	MainMenu,
	BoardGame,
	MiniGame
}

var currentGameState
var continueGame

func _ready() -> void:
	currentGameState = GameState.MainMenu
	continueGame = true
	mainLoop()
	
func mainLoop() -> void:
	while continueGame:
		switch currentGameState:
			case 
