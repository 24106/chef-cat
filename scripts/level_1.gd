extends Node2D

var required_ingredients = ["lettuce", "tomato", "cucumber"]

@onready var arrow = $UIlayer/arrow
@onready var player = $player

@onready var tutorialpanel = $UIlayer/tutorialpanel
@onready var tutorialtext = $UIlayer/tutorialpanel/Label
@onready var tutorialbutton = $UIlayer/tutorialpanel/Button

@onready var tomato_label = $UIlayer/ingredientUI/tomatotext
@onready var lettuce_label = $UIlayer/ingredientUI/lettucetext
@onready var cucumber_label = $UIlayer/ingredientUI/cucumbertext


func _ready():
	arrow.visible = false
	tutorialbutton.visible = true
	tutorialpanel.visible = true
	tutorialtext.visible = true


func _physics_process(delta):
	pause()
	check_ingredients()
	update_ingredient_UI()


func pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/pausemenu.tscn")


func check_ingredients():
	if player.collected_ingredients.size() >= required_ingredients.size():
		arrow.visible = true
	else:
		arrow.visible = false


func update_ingredient_UI():

	if "tomato" in player.collected_ingredients:
		tomato_label.text = "Tomato ✓"
	else:
		tomato_label.text = "Tomato"


	if "lettuce" in player.collected_ingredients:
		lettuce_label.text = "Lettuce ✓"
	else:
		lettuce_label.text = "Lettuce"


	if "cucumber" in player.collected_ingredients:
		cucumber_label.text = "Cucumber ✓"
	else:
		cucumber_label.text = "Cucumber"


func _on_button_pressed() -> void:
	tutorialbutton.visible = false
	tutorialpanel.visible = false
	tutorialtext.visible = false
