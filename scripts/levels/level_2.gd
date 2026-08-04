extends Node2D

var required_ingredients = ["pasta", "tomatosauce", "mushrooms"]
var ingredients_started = false

@onready var arrow = $"UI layer"/arrow
@onready var player = $player

@onready var tutorialpanel = $"UI layer"/tutorialpanel
@onready var tutorialtext = $"UI layer"/tutorialpanel/Label
@onready var tutorialbutton = $"UI layer"/tutorialpanel/Button

@onready var pasta_tick = $UIlayer/ingredientUI/pasta_tick
@onready var sauce_tick = $UIlayer/ingredientUI/sauce_tick
@onready var mushrooms_tick = $UIlayer/ingredientUI/mushrooms_tick
@onready var sauce_cross = $UIlayer/ingredientUI/sauce_cross

@onready var tomatosauce_timer = $"UI layer"/tomatosauce_timer
@onready var tomatosauce = $ingredients/tomatosauce

func _ready():
	arrow.visible = false
	tutorialbutton.visible = true
	tutorialpanel.visible = true
	tutorialtext.visible = true
	pasta_tick.visible = false
	sauce_tick.visible = false
	mushrooms_tick.visible = false
	sauce_cross.visible = false


func _physics_process(delta):
	pause()
	check_ingredients()
	update_ingredient_UI()

	if tomatosauce:
		var time_left = tomatosauce.spoil_time - tomatosauce.timer
		
		tomatosauce_timer.visible = true
		
		if time_left > 0:
			tomatosauce_timer.text = "spoils in: " + str(round(time_left))
		else:
			sauce_cross.visible = true
	else:
		tomatosauce_timer.visible = false


func pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func check_ingredients():
	if player.ingredient_failed:
		arrow.visible = false
		return

	if player.collected_ingredients.size() >= required_ingredients.size():
		arrow.visible = true
	else:
		arrow.visible = false


func update_ingredient_UI():

	if "pasta" in player.collected_ingredients:
		pasta_tick.visible = true
	else:
		pasta_tick.visible = false


	if "tomatosauce" in player.collected_ingredients:
		sauce_tick.visible = true
	else:
		sauce_tick.visible = false


	if "mushrooms" in player.collected_ingredients:
		mushrooms_tick.visible = true
	else:
		mushrooms_tick.visible = false


func _on_button_pressed() -> void:
	tutorialbutton.visible = false
	tutorialpanel.visible = false
	tutorialtext.visible = false
	
	start_ingredients()

func start_ingredients():
	if ingredients_started:
		return
	
	ingredients_started = true
	
	tomatosauce.start_timer()
