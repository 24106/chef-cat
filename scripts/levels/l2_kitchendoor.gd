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

		if player.collected_ingredients.size() >= 3:
			get_tree().change_scene_to_file("res://scenes/l2_cookingscene.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/level_2_lose_screen.tscn")
