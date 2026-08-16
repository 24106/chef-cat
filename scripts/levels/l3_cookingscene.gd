extends Node2D


@onready var question = $question
@onready var correctanswer = $correctanswer


func _ready():
	correctanswer.visible = false


func correct_answer():
	$Label2.visible = false
	$ingredientUI.visible = false
	question.visible = false
	correctanswer.visible = true

	AudioManager.music.stream_paused = true
	AudioManager.sfx.stream = AudioManager.right_option
	AudioManager.sfx.play()

	await AudioManager.sfx.finished

	get_tree().change_scene_to_file("res://scenes/levels/level_3_win_screen.tscn")


func wrong_answer():
	AudioManager.music.stream_paused = true
	AudioManager.sfx.stream = AudioManager.wrong_option
	AudioManager.sfx.play()

	await AudioManager.sfx.finished

	get_tree().change_scene_to_file("res://scenes/levels/level_3_lose_screen.tscn")


func _on_button_pressed() -> void:
	wrong_answer()


func _on_button_2_pressed() -> void:
	wrong_answer()


func _on_button_3_pressed() -> void:
	correct_answer()
