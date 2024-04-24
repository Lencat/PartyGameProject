extends Node

@export var mob_scene: PackedScene
var score_blue
var score_red
var score_green
var score_yellow
var end_game


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
	$Hud.show_message("Finished\n" + "Blue score: " + str(score_blue) + 
	"\nRed score: " + str(score_red) + "\nGreen score: " + str(score_green) +
	"\nYellow score: " + str(score_yellow))

func new_game():
	score_blue = 0
	score_red = 0
	score_green = 0
	score_yellow = 0
	end_game = 0
	$PlayerBlue.start($StartPosition.position)
	$PlayerRed.start($StartPosition.position)
	$PlayerGreen.start($StartPosition.position)
	$PlayerYellow.start($StartPosition.position)
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
	$MobTimer.start()
	$ScoreTimerBlue.start()
	$ScoreTimerRed.start()
	$ScoreTimerGreen.start()
	$ScoreTimerYellow.start()
	
	
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)


