extends Node2D

@onready var main_section = $mainsection
@onready var level_section = $levelselectsection

func _ready():
	main_section.show()
	level_section.hide()

# main section buttons
func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()

func _on_select_level_button_pressed() -> void:
	main_section.hide()
	level_section.show()


# level select section buttons
func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")

func _on_back_button_pressed() -> void:
	main_section.show()
	level_section.hide()
