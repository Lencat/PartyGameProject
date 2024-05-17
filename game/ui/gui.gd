extends Control

signal s_roll
signal s_end_turn

@onready var menus = [
	$pc_info,
	$turn_prompt,
	$move_prompt,
	$new_round_popup,
	$new_turn_popup,
	$minigame_results,
	$game_results
]
enum menu {
	pc_info = 0,
	turn_prompt = 1,
	move_prompt = 2,
	new_round_popup = 3,
	new_turn_popup = 4,
	minigame_results = 5,
	game_results = 6
}

enum menu_state {
	hidden,
	normal,
	turn,
	move,
	minigame_end,
	game_end
}

#can use for blocking improper inputs / mode changes in the future, but doesn't do much rn
var current_menu_state

# Called when the node enters the scene tree for the first time.
func _ready():
	current_menu_state = menu_state.hidden
	
	for i in range(len(menus)):
		fade_mutexes.append(Mutex.new())
	exit_mutex = Mutex.new()
	thread_exit.connect(_close_threads)

func set_pc_info(player_dict):
	menus[menu.pc_info].set_player_dict(player_dict)

func update_pc_info(names = true, clues = true):
	menus[menu.pc_info].update_pc_info(names, clues)

func show_pc_info():
	if current_menu_state == menu_state.hidden:
		current_menu_state = menu_state.normal
	#
	#menus[menu.pc_info].set_block_signals(false)
	fade_in(menu.pc_info)

func hide_pc_info():
	if current_menu_state == menu_state.normal:
		current_menu_state = menu_state.hidden
	#menus[menu.pc_info].set_block_signals(true)
	fade_out(menu.pc_info)

func show_new_round_popup(round_number):
	menus[menu.new_round_popup].display_sign("Round "+str(round_number), 3.0)

func show_new_turn_popup(player_name, slot_number):
	if $new_round_popup/sign_animation.is_playing():
		await $new_round_popup/sign_animation.animation_finished
	menus[menu.new_turn_popup].display_headstone(player_name, "Player "+str(slot_number+1), 3.0)

func show_turn_prompt():
	if $new_turn_popup/headstone_animation.is_playing():
		await $new_turn_popup/headstone_animation.animation_finished
	current_menu_state = menu_state.turn
	#menus[menu.turn_prompt].set_block_signals(false)
	fade_in(menu.turn_prompt)
	
func hide_turn_prompt():
	current_menu_state = menu_state.normal
	#menus[menu.turn_prompt].set_block_signals(true)
	fade_out(menu.turn_prompt)

func show_move_prompt():
	#menus[menu.move_prompt].set_block_signals(false)
	fade_in(menu.move_prompt)

func hide_move_prompt():
	#menus[menu.move_prompt].set_block_signals(false)
	fade_out(menu.move_prompt)

func show_minigame_results(game_name, points_name, p1name, p1score, p2name, p2score, p3name, p3score, p4name, p4score):
	current_menu_state = menu_state.minigame_end
	menus[menu.minigame_results].set_results(game_name, points_name, p1name, p1score, p2name, p2score, p3name, p3score, p4name, p4score)
	#menus[menu.minigame_results].set_block_signals(false)
	fade_in(menu.minigame_results)

func hide_minigame_results():
	current_menu_state = menu_state.normal
	#menus[menu.minigame_results].set_block_signals(true)
	fade_out(menu.minigame_results)

func show_game_results(game_name, points_name, p1name, p1score, p2name, p2score, p3name, p3score, p4name, p4score):
	current_menu_state = menu_state.game_end
	menus[menu.game_results].set_results(game_name, points_name, p1name, p1score, p2name, p2score, p3name, p3score, p4name, p4score)
	#menus[menu.game_results].set_block_signals(false)
	fade_in(menu.game_results)

func log_message(message : String):
	$message_log.log_message(message)

func fade_in(menu_index : int):
	var thread = Thread.new()
	threads.append(thread)
	thread.start(_fade_in_thread.bind(menu_index, menus[menu_index].visible, menus[menu_index].modulate.a))

func fade_out(menu_index : int):
	var thread = Thread.new()
	threads.append(thread)
	thread.start(_fade_out_thread.bind(menu_index, menus[menu_index].visible, menus[menu_index].modulate.a))

func _fade_in_thread(menu_index : int, start_visible : bool, start_a : float) -> void:
	#if invisible, makes node visible first
	#sets respective modulate to fully transparent first to avoid pop-in
	if start_visible == false:
		start_a = 0.0
		call_deferred("_set_menu_modulate_a", menu_index, start_a)
		call_deferred("_set_menu_visible", menu_index, true)
	
	var fade_duration_sec : float = 0.8
	var step_sec          : float = 0.05
	var step_count        : float = fade_duration_sec / step_sec
	var step_size         : float = (1.0 - start_a) / step_count
	
	var current_a : float = start_a
	#gradually make node fully visible
	while current_a < 1.0:
		current_a += step_size
		call_deferred("_set_menu_modulate_a", menu_index, current_a)
		await get_tree().create_timer(step_sec).timeout
	#not sure if it can go over 1 but better to be safe
	call_deferred("_set_menu_modulate_a", menu_index, 1.0)
	
	#done
	thread_exit.emit()

func _fade_out_thread(menu_index : int, start_visible : bool, start_a : float) -> void:
	# If node is already invisible, skip everything
	if start_visible == false:
		thread_exit.emit()
		return
	
	var fade_duration_sec : float = 0.4
	var step_sec          : float = 0.05
	var step_count        : float = fade_duration_sec / step_sec
	var step_size         : float = start_a / step_count
	
	var current_a = start_a
	
	while current_a > 0.0:
		current_a -= step_size
		call_deferred("_set_menu_modulate_a", menu_index, current_a)
		await get_tree().create_timer(step_sec).timeout
	#not sure if it can go under 0 but better to be safe
	call_deferred("_set_menu_modulate_a", menu_index, 0.0)
	
	#make node truly invisible when done
	call_deferred("_set_menu_visible", menu_index, false)
	
	#done
	thread_exit.emit()

#can't modify scene items from inside threads; have to use these setters
func _set_menu_visible(menu_index : int, value : bool):
	menus[menu_index].visible = value

func _set_menu_modulate_a(menu_index : int, value : float):
	menus[menu_index].modulate.a = value
	if menu_index == 0:
		tint_red.set_shader_parameter("alpha", value)
		tint_blue.set_shader_parameter("alpha", value)
		tint_green.set_shader_parameter("alpha", value)
		tint_yellow.set_shader_parameter("alpha", value)

#temp workaround
@onready var tint_red : ShaderMaterial = $pc_info/box_overall/box_top_left/PlayerPlacard1.material
@onready var tint_blue : ShaderMaterial = $pc_info/box_overall/box_top_right/PlayerPlacard2.material
@onready var tint_green : ShaderMaterial = $pc_info/box_overall/box_bottom_left/PlayerPlacard3.material
@onready var tint_yellow : ShaderMaterial = $pc_info/box_overall/box_bottom_right/PlayerPlacard4.material

# anti-softlock
func reset_menus() -> void:
	var display_pc_info = (current_menu_state == menu_state.hidden)
	var display_turn_prompt = (current_menu_state == menu_state.turn) or (current_menu_state == menu_state.turn)
	var display_move_prompt = (current_menu_state == menu_state.move) or (current_menu_state == menu_state.move)
	var display_minigame_results = (current_menu_state == menu_state.minigame_end)
	var display_game_results = (current_menu_state == menu_state.game_end)
	
	if display_pc_info:
		#menus[menu.pc_info].set_block_signals(false)
		fade_in(menu.pc_info)
	else:
		#menus[menu.pc_info].set_block_signals(true)
		fade_out(menu.pc_info)
	
	if display_turn_prompt:
		#menus[menu.turn_prompt].set_block_signals(false)
		fade_in(menu.turn_prompt)
	else:
		#menus[menu.turn_prompt].set_block_signals(true)
		fade_out(menu.turn_prompt)
	
	if display_move_prompt:
		#menus[menu.move_prompt].set_block_signals(false)
		fade_in(menu.move_prompt)
	else:
		#menus[menu.move_prompt].set_block_signals(true)
		fade_out(menu.move_prompt)
	
	if display_minigame_results:
		#menus[menu.minigame_results].set_block_signals(false)
		fade_in(menu.minigame_results)
	else:
		#menus[menu.minigame_results].set_block_signals(true)
		fade_out(menu.minigame_results)
	
	if display_game_results:
		#menus[menu.game_results].set_block_signals(false)
		fade_in(menu.game_results)
	else:
		#menus[menu.game_results].set_block_signals(true)
		fade_out(menu.game_results)

# thread stuff
var fade_mutexes = []
var exit_mutex : Mutex
var threads = []
signal thread_exit

func _close_threads():
	exit_mutex.lock()
	for i in range(len(threads)):
		threads[i].wait_to_finish()
	for i in range(len(threads)):
		threads.pop_front()
	exit_mutex.unlock()

func _exit_tree():
	_close_threads()
