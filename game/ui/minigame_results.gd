extends MarginContainer

@onready var label_title = $CenterContainer/VBoxContainer/title
@onready var label_p1name = $CenterContainer/VBoxContainer/box1/HBoxContainer/name
@onready var label_p1score = $CenterContainer/VBoxContainer/box1/HBoxContainer/score
@onready var label_p2name = $CenterContainer/VBoxContainer/box2/HBoxContainer/name
@onready var label_p2score = $CenterContainer/VBoxContainer/box2/HBoxContainer/score
@onready var label_p3name = $CenterContainer/VBoxContainer/box3/HBoxContainer/name
@onready var label_p3score = $CenterContainer/VBoxContainer/box3/HBoxContainer/score
@onready var label_p4name = $CenterContainer/VBoxContainer/box4/HBoxContainer/name
@onready var label_p4score = $CenterContainer/VBoxContainer/box4/HBoxContainer/score

var placement = ["0th", "1st", "2nd", "3rd", "4th"]

func _ready():
	visible = false

func set_results(game_name, points_name, p1name, p1score, p2name, p2score, p3name, p3score, p4name, p4score):
	#name, score, place
	var scores = [[p1name,p1score,1],[p2name,p2score,1],[p3name,p3score,1],[p4name,p4score,1]]
	scores.sort_custom(func(a,b): return a[1] > b[1])
	
	var number_of_winners : int = 1
	
	#setting place
	for i in range (1,4):
		if scores[i][1] == scores[i-1][1]:
			if scores[i-1][2] == 1:
				number_of_winners += 1
		else:
			scores[i][2] = i+1
	
	#adding winner names
	var title : String = game_name + " over!\n"+scores[0][0]
	match number_of_winners:
		1:
			title += " wins!"
		2:
			title += " and "+scores[1][0]+"win!"
		3:
			title += ", "+scores[1][0]+", and "+scores[2][0]+" win!"
		4:
			title += ", "+scores[1][0]+", "+scores[2][0]+", and "+scores[3][0]+" all win!"
	
	label_title.text = title
	label_p1name = placement[scores[0][2]]+" place: "+scores[0][0]
	label_p1score = ""+scores[0][1]+" "+points_name
	label_p2name = placement[scores[1][2]]+" place: "+scores[1][0]
	label_p2score = ""+scores[1][1]+" "+points_name
	label_p3name = placement[scores[2][2]]+" place: "+scores[2][0]
	label_p3score = ""+scores[2][1]+" "+points_name
	label_p4name = placement[scores[3][2]]+" place: "+scores[3][0]
	label_p4score = ""+scores[3][1]+" "+points_name
