extends CharacterBody2D

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
#@export var target_to_chase: Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_area: Area2D = $Area2D

@export var players: Array

const BASE_SPEED = 50
var current_speed = BASE_SPEED
var time_elapsed = 0.0
@export var speed_increase_rate = 5.0
var is_game_active = false

func _ready() -> void:
	set_physics_process(false)
	call_deferred("wait_for_physics")
	collision_area.connect("body_entered", Callable(self, "_on_body_entered"))

func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if not is_game_active:
		velocity = Vector2.ZERO
		return
	time_elapsed += delta
	current_speed = BASE_SPEED + (time_elapsed * speed_increase_rate)

	var closest_player = find_closest_player()
	if closest_player:
		navigation_agent.target_position = closest_player.global_position
		velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * current_speed
		
		# flip the sprite to face the nearest player.
		sprite.flip_h = closest_player.global_position.x < global_position.x
	else:
			velocity = Vector2.ZERO
	move_and_slide()

func find_closest_player() -> Area2D:
	var closest_distance = INF
	var closest_player: Area2D = null  # Explicitly declare the type as Area2D

	for player in players:
		if player.visible:  # Only consider visible (active) players
			var distance = global_position.distance_to(player.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_player = player

	return closest_player


func _on_body_entered(body):
	if body.name.contains("Player"):
		body.hide()
		body.emit_signal("hit")
		
