extends CharacterBody3D

@onready var name_label = $PlayerName
var camera

const MAX_SPEED = 2.0
const ACCELERATION = 1.0
const MOVE_TIMEOUT = 3.0

const characters = [
	"res://characters/artist/artist.tscn",
	"res://characters/astrologist/astrologist.tscn",
	"res://characters/citizen/citizen.tscn",
]
enum character {
	artist = 0,
	astrologer = 1,
	citizen = 2,
}

var current_sprite
var prior_position
var target_position
var anti_softlock_timer
signal arrived_at_target

func _ready():
	current_sprite = null
	target_position = position
	anti_softlock_timer = Timer.new()
	anti_softlock_timer.timeout.connect(warp_to_target_position)
	add_child(anti_softlock_timer)
	set_physics_process(false)

func _physics_process(delta):
	if position.distance_to(target_position) > 0.1:
		position += (target_position - position)/3
	else:
		position = target_position
	
	camera.position = position
	if position.distance_to(target_position) < 0.01:
		arrived_at_target.emit()
		anti_softlock_timer.stop()
		set_physics_process(false)

func set_camera(new_camera):
	camera = new_camera

func set_target_position(new_position : Vector3):
	target_position = new_position
	anti_softlock_timer.start(MOVE_TIMEOUT)
	set_physics_process(true)

func warp_to_target_position():
	position = target_position
	velocity = Vector3.ZERO
	set_physics_process(false)

func set_player_name(new_name : String):
	name_label.text = new_name

func set_character_model(index : int):
	if current_sprite != null:
		current_sprite.visible = false
	var new_sprite = load(characters[index])
	if new_sprite == null:
		return
	current_sprite = new_sprite.instantiate()
	add_child(current_sprite)
