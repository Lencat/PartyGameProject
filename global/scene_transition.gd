extends CanvasLayer

@onready var transition_anim := $AnimationPlayer
var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)

func add_scene(path) -> void:
	#make sure scene exists first
	if ResourceLoader.exists(path) == false:
		print_debug('Attempted to load non-existent scene: "%s"' % path)
		return
	
	#load from preloader if preloaded, else load directly
	var new_scene = ResourceLoader.load_threaded_get(path)
	if new_scene == null:
		new_scene = load(path)
	
	#instantiate scene
	var scene_to_add = new_scene.instantiate()
	
	#add scene to root
	get_tree().root.add_child(scene_to_add)

func switch_scene(path) -> void:
	transition_anim.play("fade transition")
	await transition_anim.animation_finished
	call_deferred("_deferred_switch_scene", path)
	transition_anim.play_backwards("fade transition")

func _deferred_switch_scene(path) -> void:
	#make sure scene exists first
	if ResourceLoader.exists(path) == false:
		print_debug('Attempted to load non-existent scene: "%s"' % path)
		return
	
	#unload current scene
	current_scene.free()
	
	#load from preloader if preloaded, else load directly
	var new_scene = ResourceLoader.load_threaded_get(path)
	if new_scene == null:
		new_scene = load(path)
	
	#instantiate scene, set it as new current scene
	current_scene = new_scene.instantiate()
	
	#add scene to root, also set it as root's current scene
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func preload_scene(path) -> void:
	if ResourceLoader.exists(path) == false:
		print_debug('Attempted to preload non-existent scene: "%s"' % path)
		return
	
	ResourceLoader.load_threaded_request(path)
