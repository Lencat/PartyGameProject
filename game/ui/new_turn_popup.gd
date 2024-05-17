extends MarginContainer

@onready var headstone_animation := $headstone_animation
@onready var headstone_name := $headstone/VBoxContainer/name
@onready var headstone_slot := $headstone/VBoxContainer/slot
@onready var sfx := $new_turn_sfx

var headstone_mutex : Mutex

func _ready():
	visible = false
	headstone_mutex = Mutex.new()

func raise_headstone() -> void:
	headstone_mutex.lock()
	visible = true
	headstone_animation.play("headstone_raise")

func lower_headstone() -> void:
	headstone_mutex.lock()
	headstone_animation.play("headstone_sink")

func label_headstone(name : String, slot : String) -> void:
	headstone_name.text = name
	headstone_slot.text = slot

func display_headstone(name : String, slot : String, duration_sec : float) -> void:
	label_headstone(name, slot)
	raise_headstone()
	sfx.play()
	get_tree().create_timer(duration_sec).timeout.connect(lower_headstone)

func _on_headstone_animation_animation_finished(anim_name):
	if anim_name == "headstone_sink":
		visible = false
	_unlock_headstone_mutex()

func _unlock_headstone_mutex():
	headstone_mutex.unlock()
