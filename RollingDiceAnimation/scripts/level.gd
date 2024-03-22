extends Node3D

@onready var result_label 

func _on_die_roll_finished(value):
	result_label = str(value)
	print(result_label)
