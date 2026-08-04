extends Node2D

var required_ingredients = ["lettuce", "tomato", "cucumber"]

@onready var arrow_kitchen = $UIlayer/arrow_kitchen
@onready var player = $player

@onready var tutorialpanel = $UIlayer/tutorialpanel
@onready var tutorialtext = $UIlayer/tutorialpanel/Label
@onready var tutorialbutton = $UIlayer/tutorialpanel/Button

@onready var tomato_tick = $UIlayer/ingredientUI/tomato_tick
@onready var lettuce_tick = $UIlayer/ingredientUI/lettuce_tick
@onready var cucumber_tick = $UIlayer/ingredientUI/cucumber_tick


func _ready():
	arrow_kitchen.visible = false
	tutorialbutton.visible = true
	tutorialpanel.visible = true
	tutorialtext.visible = true
	tomato_tick.visible = false
	cucumber_tick.visible = false
	lettuce_tick.visible = false


func _physics_process(delta):
	pause()
	check_ingredients()
	update_ingredient_UI()


func pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func check_ingredients():
	if player.collected_ingredients.size() >= required_ingredients.size():
		arrow_kitchen.visible = true
	else:
		arrow_kitchen.visible = false


func update_ingredient_UI():

	if "tomato" in player.collected_ingredients:
		tomato_tick.visible = true
	else:
		tomato_tick.visible = false


	if "lettuce" in player.collected_ingredients:
		lettuce_tick.visible = true
	else:
		lettuce_tick.visible = false


	if "cucumber" in player.collected_ingredients:
		cucumber_tick.visible = true
	else:
		cucumber_tick.visible = false


func _on_button_pressed() -> void:
	tutorialbutton.visible = false
	tutorialpanel.visible = false
	tutorialtext.visible = false
