extends Node

@export var mob_scene: PackedScene
#The minigame was made with the players named after colors for the initial placeholders.
#These are the corosponding colors to players, changing the names of everything can come later.
#Player1
var score_blue
#Player2
var score_red
#Player3
var score_green
#Player4
var score_yellow
var end_game
var scores
var places = [1, 2, 3, 4]
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (end_game == 4):
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
		
	if (scores[1] == score_blue) && (places[0] != 1):
		places[1] = 1
	elif (scores[1] == score_red) && (places[0] != 2):
		places[1] = 2
	elif (scores[1] == score_green) && (places[0] != 3):
		places[1] = 3
	else:
		places[1] = 4
		
	if (scores[2] == score_blue) && (places[0] != 1) && (places[1] != 1):
		places[2] = 1
	elif (scores[2] == score_red) && (places[0] != 2) && (places[1] != 2):
		places[2] = 2
	elif (scores[2] == score_green) && (places[0] != 3) && (places[1] != 3):
		places[2] = 3
	else:
		places[2] = 4
		
	if (scores[3] == score_blue) && (places[0] != 1) && (places[1] != 1) && (places[2] != 1):
		places[3] = 1
	elif (scores[3] == score_red) && (places[0] != 2) && (places[1] != 2) && (places[2] != 2):
		places[3] = 2
	elif (scores[3] == score_green) && (places[0] != 3) && (places[1] != 3) && (places[2] != 3):
		places[3] = 3
	else:
		places[3] = 4
		
	$Hud.show_message("Finished\n" + "1st: Player " + str(places[0]) + 
	"\n2nd: Player " + str(places[1]) + "\n3rd: Player " + str(places[2]) +
	"\n4th: Player" + str(places[3]))
	
	$Hud.end_game()
	
	
func sort_ascending(a, b):
	if a < b:
		return true
	return false

func new_game():
	screen_size = get_viewport().size
	#$MobPath.curve.clear_points()
	#$MobPath.curve.add_point(Vector2((screen_size.x / 2) - 240, 0))
	#$MobPath.curve.add_point(Vector2((screen_size.x / 2) + 240, 0))
	score_blue = 0
	score_red = 0
	score_green = 0
	score_yellow = 0
	end_game = 0
	$PlayerBlue.start(Vector2(screen_size.x / 2, 600))
	$PlayerRed.start(Vector2(screen_size.x / 2, 600))
	$PlayerGreen.start(Vector2(screen_size.x / 2, 600))
	$PlayerYellow.start(Vector2(screen_size.x / 2, 600))
	$Hud.show_message("Get Ready")
	$StartTimer.start()
	
	
func _on_score_timer_blue_timeout():
	score_blue += 1
	
func _on_score_timer_red_timeout():
	score_red += 1

func _on_score_timer_green_timeout():
	score_green += 1

func _on_score_timer_yellow_timeout():
	score_yellow += 1

func _on_start_timer_timeout():
	#$MobTimer.start()
	$ScoreTimerBlue.start()
	$ScoreTimerRed.start()
	$ScoreTimerGreen.start()
	$ScoreTimerYellow.start()
	
	
#func _on_mob_timer_timeout():
	#var mob = mob_scene.instantiate()
	#var mob_spawn_location = $MobPath/MobSpawnLocation
	#mob_spawn_location.progress_ratio = randf()
	#var direction = mob_spawn_location.rotation + PI / 2
	#mob.position = mob_spawn_location.position
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#mob.linear_velocity = velocity.rotated(direction)
	#add_child(mob)
