extends Node3D

var result_label 

var world_scene_path = "res://3DWorld.tscn"


func _on_die_roll_finished(value):
	result_label = str(value)
	print(result_label)
	
	# Change the scene back to the world scene, but do it deferred to avoid physics processing issues
	call_deferred("_deferred_change_scene")
	
# A deferred method to change the scene to avoid physics callback issues
func _deferred_change_scene():
	Global.next_player()
	get_tree().change_scene_to_file(world_scene_path)
