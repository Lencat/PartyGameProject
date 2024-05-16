extends Control

@onready var bUp = $BoxUp
@onready var bLeft = $BoxLeft
@onready var bRight = $BoxRight
@onready var bDown = $BoxDown

signal d_north
signal d_west
signal d_east
signal d_south

var move_mutex : Mutex
var character_temp
var distance_temp

func _ready():
	move_mutex = Mutex.new()

func show_direction_prompt(n,w,e,s,char,steps_left):
	move_mutex.lock()
	bUp.visible = n
	bLeft.visible = w
	bRight.visible = e
	bDown.visible = s
	visible = true

func hide_prompt_direction():
	visible = false
	move_mutex.unlock()	

func _on_button_north_pressed():
	hide_prompt_direction()
	d_north.emit()


func _on_button_west_pressed():
	hide_prompt_direction()
	d_west.emit()


func _on_button_east_pressed():
	hide_prompt_direction()
	d_east.emit()


func _on_button_south_pressed():
	hide_prompt_direction()
	d_south.emit()
