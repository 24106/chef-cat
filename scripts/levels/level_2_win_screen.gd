extends Node2D


@onready var next_level_button = $next_level_button
@onready var main_menu_button = $main_menu_button
@onready var restart_button = $restart_button

@onready var wait_message = $WaitMessage


func _ready():
	next_level_button.disabled = true
	main_menu_button.disabled = true
	restart_button.disabled = true

	wait_message.visible = true

	AudioManager.sfx.stream = AudioManager.level2_win
	AudioManager.sfx.play()

	await AudioManager.sfx.finished

	AudioManager.music.stream_paused = false

	next_level_button.disabled = false
	main_menu_button.disabled = false
	restart_button.disabled = false

	wait_message.visible = false


func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
