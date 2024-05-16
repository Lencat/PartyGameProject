extends Control

var splashAnimation

func _ready():
	splashAnimation = get_node("SplashAnimation")
	Controller.preload_main_menu()
	#SceneSwitcher.preload_scene(musicPlayerPath)

func _on_button_skip_button_up():
	var currentTime = splashAnimation.get_current_animation_position()
	#print_debug("Button pressed at time: %0.2f" % currentTime)
	var nextTime = (floor(currentTime/5)+1)*5
	#print_debug("Next time: %0.2f" % nextTime)
	splashAnimation.seek(nextTime)

func _on_splash_animation_finished(anim_name):
	go_to_title_screen()

func go_to_title_screen() -> void:
	#print_debug("Title screen finished.")
	Controller.goto_main_menu()
