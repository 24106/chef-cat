extends Node2D


func _on_resume_button_pressed():
	get_tree().change_scene_to_file(PauseManager.current_level)


func _on_restart_button_pressed():
	PauseManager.reset_data()
	get_tree().change_scene_to_file(PauseManager.current_level)


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
