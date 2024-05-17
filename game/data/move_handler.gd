extends Node3D

@onready var controller := $".."
@onready var gui := $"../CanvasLayer/GUI"
@onready var directionPrompt := $DirectionPrompt
@onready var cameraTarget := $"../CameraTarget"

signal end_move

var step_mutex : Mutex
var listening_for_input : bool
var stored_character
var stored_steps

# Called when the node enters the scene tree for the first time.
func _ready():
	gui.s_roll.connect(move_character)
	directionPrompt.d_north.connect(_finish_step_n)
	directionPrompt.d_west.connect(_finish_step_w)
	directionPrompt.d_east.connect(_finish_step_e)
	directionPrompt.d_south.connect(_finish_step_s)
	step_mutex = Mutex.new()

func move_character(slot = -1):
	#TODO connect step to dice roll animation finish
	var tiles_left = randi_range(1,6)
	gui.log_message("Moving... rolled a "+str(tiles_left)+".")
	if slot == -1:
		slot = controller.gameData.whoseTurn
	var moving_character = controller.gameData.players[slot]
	_step_tile(moving_character, tiles_left)

func _step_tile(moving_character, tiles_left):
	var current_position = moving_character.position
	var current_tile = controller.gameData.board.tiles[Vector2i(current_position)]
	
	tiles_left + (1 if current_tile.tile_type == controller.tile_type.slippery else 0)
	
	if tiles_left == 0:
		_land_on_tile(moving_character)
		return
	
	var outs = [
		current_tile.n == controller.IO.o,
		current_tile.w == controller.IO.o,
		current_tile.e == controller.IO.o,
		current_tile.s == controller.IO.o
	]
	
	if outs.count(true) == 1:
		if outs[0]:
			moving_character.position.y += 1
		elif outs[1]:
			moving_character.position.x -= 1
		elif outs[2]:
			moving_character.position.x += 1
		elif outs[3]:
			moving_character.position.y -= 1
		#visually move
		_move_character_visuals(moving_character.character, moving_character.position.x, moving_character.position.y)
		await get_tree().create_timer(0.5).timeout
		_step_tile(moving_character, tiles_left-1)
	else:
		step_mutex.lock()
		listening_for_input = true
		stored_character = moving_character
		stored_steps = tiles_left-1
		directionPrompt.show_direction_prompt(outs[0], outs[1], outs[2], outs[3], moving_character, tiles_left)

func _finish_step_n():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.y += 1
		_move_character_visuals(char.character, char.position.x, char.position.y)
		await get_tree().create_timer(0.5).timeout
		step_mutex.unlock()
		_step_tile(char, steps)

func _finish_step_w():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.x -= 1
		_move_character_visuals(char.character, char.position.x, char.position.y)
		await get_tree().create_timer(0.5).timeout
		step_mutex.unlock()
		_step_tile(char, steps)

func _finish_step_e():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.x += 1
		_move_character_visuals(char.character, char.position.x, char.position.y)
		await get_tree().create_timer(0.5).timeout
		step_mutex.unlock()
		_step_tile(char, steps)

func _finish_step_s():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.y -= 1
		_move_character_visuals(char.character, char.position.x, char.position.y)
		await get_tree().create_timer(0.5).timeout
		step_mutex.unlock()
		_step_tile(char, steps)

func _land_on_tile(character):
	var tile = controller.gameData.board.tiles[character.position]
	match tile.tile_type:
		controller.tile_type.blank, controller.tile_type.slippery:
			#nothing special happens
			pass
		controller.tile_type.home:
			#TODO, not handling clue banking in current version
			gui.log_message(character.name + " landed at home.")
		controller.tile_type.clue:
			character.clues_held += 1
			gui.update_pc_info(false, true)
			gui.log_message(character.name + " landed on a clue tile and found a clue!")
		controller.tile_type.haunt:
			gui.log_message(character.name + " landed on a haunt tile!")
			controller.start_minigame()
		controller.tile_type.dash:
			gui.log_message(character.name + " landed on a dash tile!")
			move_character()
			return
	end_move.emit()

func _move_character_visuals(character, x, y):
	var position_3d = Vector3(
		controller.gameData.board.visualTransformX.call(x),
		0,
		controller.gameData.board.visualTransformY.call(y)
	)
	character.set_target_position(position_3d)
	print_debug(position_3d)
