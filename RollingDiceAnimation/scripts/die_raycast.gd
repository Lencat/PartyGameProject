# This script extends the functionality of a RayCast3D node in Godot Engine, primarily
# designed for use in a 3D dice rolling system. Each RayCast3D node with this script attached
# is intended to represent a face of a dice, specifically by targeting the ground or surface
# opposite to the dice face it represents.
extends RayCast3D

# Variable:
# `opposite_side`: An exported integer variable that represents the number on the dice
# face opposite to the one this RayCast3D node points towards. This variable allows for easy 
# customization without modifying the script directly. It's crucial for determining the outcome 
# of a dice roll based on which raycast(s) detect a collision.
@export var opposite_side: int


func _ready():
	# This method configures the raycast to ignore collisions with its own parent node (`owner`). 
	# This is particularly important in a dice rolling context to prevent the raycasts, which are 
	# likely children of the dice node, from colliding with the dice itself. We only want them to 
	# detect the floor and the walls
	add_exception(owner)

