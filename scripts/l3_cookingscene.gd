extends Node2D


@onready var question = $question

@onready var correctanswer = $correctanswer

@onready var next = $levelcompletionbutton


func _ready():

	correctanswer.visible = false
	next.visible = false


func correct_answer():
	$Label2.visible = false
	$ingredientUI.visible = false
	question.visible = false
	correctanswer.visible = true
	next.visible = true


func wrong_answer():
	get_tree().change_scene_to_file("res://scenes/level_3_lose_screen.tscn")


func _on_button_pressed() -> void:
	wrong_answer()

func _on_button_2_pressed() -> void:
	wrong_answer()

func _on_button_3_pressed() -> void:
	correct_answer()


func _on_levelcompletionbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3_win_screen.tscn")
