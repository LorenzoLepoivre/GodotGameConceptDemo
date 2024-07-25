extends Control

func _ready():
	AutoLoad.is_in_menu = true
	
func _on_play_button_pressed():
	AutoLoad.is_in_menu = false
	get_tree().change_scene_to_file(AutoLoad.ALL_LEVELS[AutoLoad.actualDonjon][AutoLoad.actualLevel])

func _on_quit_button_pressed():
	get_tree().quit()

func _on_best_button_pressed():
	get_tree().change_scene_to_file("res://Levels/bestiaire.tscn")
