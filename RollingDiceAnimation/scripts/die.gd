# Extends RigidBody3D, allowing this script to control a 3D physics body.
# This script is designed to simulate a dice roll in Godot Engine, utilizing physics and raycasts 
# to determine the outcome.
extends RigidBody3D

# Array to hold RayCast nodes. These nodes are used to detect which face of the dice is facing 
# upwards upon landing.
@onready var raycasts = $Raycasts.get_children()

# Variable to store the starting position of the dice to reset it to this position at the start of
# each roll.
var start_pos

# The strength of the roll. Higher values will make the dice roll more vigorously.
var roll_strength = 30

# Flag to indicate whether the dice is currently rolling. Prevents initiating another roll while
# one is in progress.
var is_rolling = false

# Custom signal to notify when the roll has finished and to pass the result of the roll.
signal roll_finished(value)

func _ready():
	# Initialize the starting position with the dice's global position at game start.
	start_pos = global_position 

func _input(event):
	# Listens for the 'ui_accept' action (e.g., pressing the Space key).
	# If pressed and the dice is not rolling, initiates a roll.
	if event.is_action_pressed("ui_accept") && !is_rolling:
		_roll()

func _roll():
	# Resets the dice's physics state for a consistent start to each roll.
	sleeping = false
	freeze = false
	transform.origin = start_pos
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	# Applies random rotations to the dice for a varied starting orientation.
	transform.basis = Basis(Vector3.RIGHT, randf_range(0, 2 * PI)) * transform.basis
	transform.basis = Basis(Vector3.UP, randf_range(0, 2 * PI)) * transform.basis
	transform.basis = Basis(Vector3.FORWARD, randf_range(0, 2 * PI)) * transform.basis
	
	# Determines a random direction and applies both force and torque to simulate the roll.
	var throw_vector = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	angular_velocity = throw_vector * roll_strength / 2
	apply_central_impulse(throw_vector * roll_strength)
	is_rolling = true


func _on_sleeping_state_changed():
	# Triggered when the dice stops moving, indicating the roll is complete.
	if sleeping:
		var landed_on_side = false
		# Iterates through each raycast to check if the dice has landed on a side.
		for raycast in raycasts:
			# Emits the roll_finished signal with the result and stops the roll.
			if raycast.is_colliding():
				roll_finished.emit(raycast.opposite_side)
				is_rolling = false
				landed_on_side = true
		# If no side is detected, initiates another roll. This handles edge cases where the dice 
		# may land awkwardly.
		if !landed_on_side:
			_roll()
			
