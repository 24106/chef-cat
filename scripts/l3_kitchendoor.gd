extends Area2D

var player_in_range = false
var player

@onready var prompt = $Label


func _ready():
	prompt.visible = false


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		player = body


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		player = null


func _process(delta):
	prompt.visible = player_in_range


func _input(event):
	if player_in_range:
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
				enter_kitchen()


func enter_kitchen():
	if player:
		print("Player reached kitchen")
		print("Ingredients:", player.collected_ingredients)

		if player.collected_ingredients.size() >= 3:
			print("WIN")
			get_tree().change_scene_to_file("res://scenes/level_3_win_screen.tscn")
		else:
			print("FAIL")
			get_tree().change_scene_to_file("res://scenes/level_3_lose_screen.tscn")
