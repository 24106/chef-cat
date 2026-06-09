extends Node2D

# main section buttons
func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()

func _on_select_level_button_pressed() -> void:
	global_position = Vector2(200, 60)


# level select section buttons
func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")

func _on_back_button_pressed() -> void:
	pass # Replace with function body.
