extends Node2D

var required_ingredients = ["icecream", "chocolatesauce", "strawberries"]

@onready var arrow = $"UI layer"/arrow
@onready var player = $player

@onready var tutorialpanel = $"UI layer"/tutorialpanel
@onready var tutorialtext = $"UI layer"/tutorialpanel/Label
@onready var tutorialbutton = $"UI layer"/tutorialpanel/Button

@onready var icecream_label = $"UI layer"/ingredientUI/icecreamtext
@onready var chocolatesauce_label = $"UI layer"/ingredientUI/chocolatesaucetext
@onready var strawberries_label = $"UI layer"/ingredientUI/strawberriestext


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

	if "icecream" in player.collected_ingredients:
		icecream_label.text = "Ice cream ✓"
	else:
		icecream_label.text = "Ice cream"


	if "chocolatesauce" in player.collected_ingredients:
		chocolatesauce_label.text = "Chocolate sauce ✓"
	else:
		chocolatesauce_label.text = "Chocolate sauce"


	if "strawberries" in player.collected_ingredients:
		strawberries_label.text = "Strawberries ✓"
	else:
		strawberries_label.text = "Strawberries"


func _on_button_pressed() -> void:
	tutorialbutton.visible = false
	tutorialpanel.visible = false
	tutorialtext.visible = false
