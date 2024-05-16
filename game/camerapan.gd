extends Node3D

@onready var camera : Camera3D = $OverheadCamera
@onready var target_normal : Node3D = $"../CameraTarget"
var target_pan : Node3D
var target_transform : Transform3D

var map_bounds_graveyard_hardcoded = [-8, 1, -7, 1]

var timer : Timer
const RESUME_AUTOTRACKING_DELAY_SECONDS : float = 3.0

var autotrack : bool = true
var update : bool = false

var pan_sensitivity : float = 0.01
var translate_speed : float = 0.3
var rotate_speed : float = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	#create pan node; don't want people confusing it for the real target so creating it on runtime
	target_pan = Node3D.new()
	target_pan.global_transform = target_normal.global_transform
	get_tree().root.add_child(target_pan)
	
	#create timer
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = RESUME_AUTOTRACKING_DELAY_SECONDS
	timer.one_shot = true
	timer.timeout.connect(_resume_autotracking)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			if autotrack == true:
				target_pan.global_transform = target_normal.global_transform
				autotrack = false
			var pan_vector : Vector3 = Vector3(-event.relative.x, 0, -event.relative.y)
			pan_vector = pan_vector.rotated(Vector3.UP,camera.rotation.y)
			pan_vector *= pan_sensitivity
			target_pan.global_transform = target_pan.global_transform.translated(pan_vector)
			enforce_map_bounds()
			timer.start()

func _resume_autotracking() -> void:
	autotrack = true
	
func enforce_map_bounds() -> void:
	#x min
	target_pan.global_position.x = max(target_pan.global_position.x, map_bounds_graveyard_hardcoded[0])
	#x max
	target_pan.global_position.x = min(target_pan.global_position.x, map_bounds_graveyard_hardcoded[1])
	#y min
	target_pan.global_position.z = max(target_pan.global_position.z, map_bounds_graveyard_hardcoded[2])
	#y max
	target_pan.global_position.z = min(target_pan.global_position.z, map_bounds_graveyard_hardcoded[3])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update:
		update_transform()
		update = false
	interpolated_transform(delta)

func _physics_process(delta):
	update = true

func update_transform() -> void:
	target_transform = target_normal.global_transform if autotrack else target_pan.global_transform

func interpolated_transform(delta) -> void:
	var translate_factor : float = translate_speed * delta * 10
	var rotate_factor : float = rotate_speed * delta * 10

	#interpolate translate/rotate individually for separate interplolation speeds
	var local_transform_only_origin := Transform3D(Basis(), get_global_transform().origin)
	var local_transform_only_basis := Transform3D(get_global_transform().basis, Vector3())
	local_transform_only_origin = local_transform_only_origin.interpolate_with(target_transform, translate_factor)
	local_transform_only_basis = local_transform_only_basis.interpolate_with(target_transform, rotate_factor)
	set_global_transform(Transform3D(local_transform_only_basis.basis, local_transform_only_origin.origin))

#current_time = Time.get_unix_time_from_system()
#if current_time - last_time > 1:
#	print(timer.time_left)
#	last_time = Time.get_unix_time_from_system()
#
#var last_time
#var current_time
