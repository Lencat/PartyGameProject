extends Node3D

@onready var controller = $".."
@onready var gui = $"../CanvasLayer/GUI"
@onready var directionPrompt = $DirectionPrompt
@onready var gameData = controller.gameData

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
	if slot == -1:
		slot = gameData.whoseTurn
	var moving_character = gameData.players[slot]
	_step_tile(slot, tiles_left)

func _step_tile(moving_character, tiles_left):
	var current_position = moving_character.position
	var current_tile = gameData.board[current_position]
	var new_tiles_left = tiles_left - 1 + (1 if current_tile.tile_type == controller.tile_type.slippery else 0)
	
	if new_tiles_left == 0:
		end_move.emit()
		return
	
	var outs = [
		current_tile.n == controller.IO.out,
		current_tile.w == controller.IO.out,
		current_tile.e == controller.IO.out,
		current_tile.s == controller.IO.out
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
		#TODO: now visially move character
		pass
		#await (done_moving)
		_step_tile(moving_character, new_tiles_left)
	else:
		step_mutex.lock()
		listening_for_input = true
		stored_character = moving_character
		stored_steps = new_tiles_left
		directionPrompt.show_direction_prompt(outs[0], outs[1], outs[2], outs[3], moving_character, tiles_left)

func _finish_step_n():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.y += 1
		#TODO: now visially move character
		pass
		#await (done_moving)
		step_mutex.unlock()
		_step_tile(char, steps)

func _finish_step_w():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.x -= 1
		#TODO: now visially move character
		pass
		#await (done_moving)
		step_mutex.unlock()
		_step_tile(char, steps)

func _finish_step_e():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.x += 1
		#TODO: now visially move character
		pass
		#await (done_moving)
		step_mutex.unlock()
		_step_tile(char, steps)

func _finish_step_s():
	if listening_for_input:
		listening_for_input = false
		var char = stored_character
		var steps = stored_steps
		char.position.y -= 1
		#TODO: now visially move character
		pass
		#await (done_moving)
		step_mutex.unlock()
		_step_tile(char, steps)

func _land_on_tile():
	pass
