extends Node2D

func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
