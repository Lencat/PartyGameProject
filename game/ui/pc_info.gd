extends MarginContainer

@onready var label_p1_name = $box_overall/box_top_left/PlayerInfo1/Name
@onready var label_p1_clues_held = $box_overall/box_top_left/PlayerInfo1/VBoxContainer/HBoxContainer/Count
@onready var label_p2_name = $box_overall/box_top_right/PlayerInfo2/Name
@onready var label_p2_clues_held = $box_overall/box_top_right/PlayerInfo2/VBoxContainer/HBoxContainer/Count
@onready var label_p3_name = $box_overall/box_bottom_left/PlayerInfo3/Name
@onready var label_p3_clues_held = $box_overall/box_bottom_left/PlayerInfo3/VBoxContainer/HBoxContainer/Count
@onready var label_p4_name = $box_overall/box_bottom_right/PlayerInfo4/Name
@onready var label_p4_clues_held = $box_overall/box_bottom_right/PlayerInfo4/VBoxContainer/HBoxContainer/Count

var player_dict

func set_player_dict(dict):
	player_dict = dict
	update_pc_info(true, true)

func update_pc_info(update_names : bool, update_clues : bool):
	if update_names:
		label_p1_name = player_dict[0].name
		label_p2_name = player_dict[1].name
		label_p3_name = player_dict[2].name
		label_p4_name = player_dict[3].name
	if update_clues:
		label_p1_clues_held = player_dict[0].clues_held
		label_p2_clues_held = player_dict[1].clues_held
		label_p3_clues_held = player_dict[2]
		label_p4_clues_held = player_dict[3]
