extends Node

var current_scene = null
var preloaded_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)

func switch_scene(res_path) -> void:
	call_deferred("_deferred_switch_scene", res_path)

func _deferred_switch_scene(res_path) -> void:
	current_scene.free()
	var new_scene = ResourceLoader.load_threaded_get(res_path)
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func preload_scene(res_path) -> void:
	ResourceLoader.load_threaded_request(res_path)
