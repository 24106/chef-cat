extends Area2D

@export var ingredient_name = "tomato"

var player_in_range = false
var collected = false

@onready var prompt = $Label

func _ready():
	prompt.visible = false
	add_to_group("ingredients")

func _process(delta):
	prompt.visible = player_in_range

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func try_collect(player):
	if collected:
		return

	collected = true
	player.add_ingredient(ingredient_name)
	print("COLLECTED:", ingredient_name)
	queue_free()
