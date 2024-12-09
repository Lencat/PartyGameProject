extends Area3D

# Reference to the dice roll scene
@export var dice_roll_scene: PackedScene

var dice_roll_instance

func _on_body_entered(body):
	if Global.players.has(body):
		# Instantiate the dice roll scene if not already done
		if not dice_roll_instance:
			dice_roll_instance = dice_roll_scene.instantiate()
			get_tree().current_scene.add_child(dice_roll_instance)
		
		# Show the dice and roll for the current player
		dice_roll_instance.show_dice(body)
