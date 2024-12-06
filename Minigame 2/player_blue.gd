extends Area2D
signal hit


@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right_blue"):
		velocity.x += 200
	if Input.is_action_pressed("move_left_blue"):
		velocity.x -= 200
	# Up and down movement
	if Input.is_action_pressed("move_up_blue"):
		velocity.y -= 200
	if Input.is_action_pressed("move_down_blue"):
		velocity.y += 200
	position += velocity * delta
	position = position.clamp(
		Vector2(0, 0),  # Adjusted for top bound
		Vector2(screen_size.x, screen_size.y)   # Adjusted for bottom bound
	)


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
