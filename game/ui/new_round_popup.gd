extends MarginContainer

@onready var sign_animation := $sign_animation
@onready var sign_label := $sign/MarginContainer/signboard/label
@onready var sfx := $new_round_sfx

var sign_mutex : Mutex

func _ready():
	visible = false
	sign_mutex = Mutex.new()

func lower_sign() -> void:
	sign_mutex.lock()
	visible = true
	sign_animation.play("sign_drop")

func raise_sign() -> void:
	sign_mutex.lock()
	sign_animation.play("sign_raise")

func label_sign(label : String) -> void:
	sign_label.text = label

func display_sign(label : String, duration_sec : float) -> void:
	label_sign(label)
	lower_sign()
	sfx.play()
	get_tree().create_timer(duration_sec).timeout.connect(raise_sign)

func _on_sign_animation_animation_finished(anim_name):
	if anim_name == "raise_sign":
		visible = false
	_unlock_sign_mutex()

func _unlock_sign_mutex():
	sign_mutex.unlock()
