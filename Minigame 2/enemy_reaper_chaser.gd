extends CharacterBody2D

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase: Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_area: Area2D = $Area2D

const BASE_SPEED = 50
var current_speed = BASE_SPEED
var time_elapsed = 0.0
@export var speed_increase_rate = 5.0

func _ready() -> void:
	set_physics_process(false)
	call_deferred("wait_for_physics")
	collision_area.connect("body_entered", Callable(self, "_on_body_entered"))

func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	current_speed = BASE_SPEED + (time_elapsed * speed_increase_rate)
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * current_speed

	# flip the sprite to face the nearest player.
	if target_to_chase.global_position.x > global_position.x:
		sprite.flip_h = false
	else:
		sprite.flip_h = true

	move_and_slide()

func _on_body_entered(body):
	if body.name == "Player":
		print("Collision with Player!")
		get_tree().quit()  # Ends the game
