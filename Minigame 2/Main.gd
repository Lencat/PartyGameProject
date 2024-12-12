extends Node

@export var mob_scene: PackedScene
@onready var players = [$PlayerBlue, $PlayerRed, $PlayerGreen, $PlayerYellow]
@onready var reaper = $Enemy
@onready var music_player = $AudioStreamPlayer

# Player-specific scores
var score_blue
var score_red
var score_green
var score_yellow

# Game state variables
var end_game
var scores
var places = [1, 2, 3, 4]
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	reaper.players = players
	reaper.is_game_active = false  # Ensure the reaper is inactive at the start
	music_player.play()
	
	# Connect the start_game signal from HUD to the _on_start_game function
	$Hud.connect("start_game", Callable(self, "_on_start_game"))
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end_game == 4:
		game_over()

func _on_player_blue_hit():
	$ScoreTimerBlue.stop()
	end_game += 1

func _on_player_red_hit():
	$ScoreTimerRed.stop()
	end_game += 1

func _on_player_green_hit():
	$ScoreTimerGreen.stop()
	end_game += 1

func _on_player_yellow_hit():
	$ScoreTimerYellow.stop()
	end_game += 1

func game_over():
	$MobTimer.stop()
	scores = [score_blue, score_red, score_green, score_yellow]
	scores.sort_custom(sort_ascending)
	scores.reverse()

	if scores[0] == score_blue:
		places[0] = 1
	elif scores[0] == score_red:
		places[0] = 2
	elif scores[0] == score_green:
		places[0] = 3
	else:
		places[0] = 4

	if scores[1] == score_blue and places[0] != 1:
		places[1] = 1
	elif scores[1] == score_red and places[0] != 2:
		places[1] = 2
	elif scores[1] == score_green and places[0] != 3:
		places[1] = 3
	else:
		places[1] = 4

	if scores[2] == score_blue and places[0] != 1 and places[1] != 1:
		places[2] = 1
	elif scores[2] == score_red and places[0] != 2 and places[1] != 2:
		places[2] = 2
	elif scores[2] == score_green and places[0] != 3 and places[1] != 3:
		places[2] = 3
	else:
		places[2] = 4

	if scores[3] == score_blue and places[0] != 1 and places[1] != 1 and places[2] != 1:
		places[3] = 1
	elif scores[3] == score_red and places[0] != 2 and places[1] != 2 and places[2] != 2:
		places[3] = 2
	elif scores[3] == score_green and places[0] != 3 and places[1] != 3 and places[2] != 3:
		places[3] = 3
	else:
		places[3] = 4

	music_player.stop()
	$Hud.show_message("Finished\n" + "1st: Player " + str(places[0]) +
					  "\n2nd: Player " + str(places[1]) +
					  "\n3rd: Player " + str(places[2]) +
					  "\n4th: Player " + str(places[3]))

	$Hud.end_game()

func sort_ascending(a, b):
	if a < b:
		return true
	return false

func new_game():
	screen_size = get_viewport().size
	score_blue = 0
	score_red = 0
	score_green = 0
	score_yellow = 0
	end_game = 0
	$PlayerBlue.start(Vector2(100, 600))
	$PlayerRed.start(Vector2(300, 600))
	$PlayerGreen.start(Vector2(700, 600))
	$PlayerYellow.start(Vector2(900, 600))
	$Hud.show_message("Get Ready")
	# Do not start the timer automatically here. Wait for the Start Button.

func _on_start_game():
	#print("Start button pressed! Starting game.")
	$StartTimer.start()  # Start the timer when the Start Button is pressed

func _on_start_timer_timeout():
	print("Start timer completed. Activating reaper and game timers.")
	$ScoreTimerBlue.start()
	$ScoreTimerRed.start()
	$ScoreTimerGreen.start()
	$ScoreTimerYellow.start()
	reaper.is_game_active = true  # Activate the reaper
