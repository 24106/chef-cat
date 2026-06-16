extends Node2D

var required_ingredients = ["lettuce", "tomato", "cucumber"]

@onready var arrow = $"UI layer"/arrow
@onready var player = $player


func _ready():
	arrow.visible = false


func _physics_process(delta):
	pause()

	check_ingredients()


func pause():
	if Input.is_action_just_pressed("pause"):
		print("PAUSE :(")


func check_ingredients():
	if player.collected_ingredients.size() >= required_ingredients.size():
		arrow.visible = true
	else:
		arrow.visible = false
