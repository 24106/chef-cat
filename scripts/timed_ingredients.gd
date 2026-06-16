extends Area2D

@export var ingredient_name = "tomatosauce"

@export var spoil_time = 10.0

var player_in_range = false
var collected = false
var spoiled = false

var timer = 0
var timer_started = false

@onready var prompt = $Label

var running = false
var can_run = false

func _ready():
	prompt.visible = false
	add_to_group("ingredients")


func _process(delta):
	if not running or not can_run:
		return

	timer += delta

	if timer >= spoil_time:
		spoil()


func spoil():
	spoiled = true
	print(ingredient_name, " spoiled!")

func start_timer():
	running = true

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		prompt.visible = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false


func try_collect(player):
	if collected:
		return

	collected = true

	if spoiled:
		player.ingredient_failed = true
	else:
		player.add_ingredient(ingredient_name)

	queue_free()
