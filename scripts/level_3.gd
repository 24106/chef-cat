extends Node2D

var required_ingredients = ["icecream", "chocolatesauce", "strawberries"]

var ingredients_started = false

@onready var arrow = $"UI layer"/arrow
@onready var player = $player

@onready var tutorialpanel = $"UI layer"/tutorialpanel
@onready var tutorialtext = $"UI layer"/tutorialpanel/Label
@onready var tutorialbutton = $"UI layer"/tutorialpanel/Button

@onready var icecream_label = $"UI layer"/ingredientUI/icecreamtext
@onready var chocolatesauce_label = $"UI layer"/ingredientUI/chocolatesaucetext
@onready var strawberries_label = $"UI layer"/ingredientUI/strawberriestext

@onready var icecream_timer = $"UI layer"/icecream_timer
@onready var icecream = $ingredients/icecream


func _ready():
	arrow.visible = false
	
	tutorialbutton.visible = true
	tutorialpanel.visible = true
	tutorialtext.visible = true
	
	icecream_timer.visible = false


func _physics_process(delta):
	pause()
	check_ingredients()
	update_ingredient_UI()

	if ingredients_started and icecream:
		var time_left = icecream.spoil_time - icecream.timer
		
		icecream_timer.visible = true
		
		if time_left > 0:
			icecream_timer.text = "Ice cream spoils in: " + str(round(time_left))
		else:
			icecream_timer.text = "Ice cream spoiled!"
	
	else:
		icecream_timer.visible = false


func pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://scenes/pausemenu.tscn")


func check_ingredients():

	if player.ingredient_failed:
		arrow.visible = false
		return

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
	
	start_ingredients()


func start_ingredients():

	if ingredients_started:
		return

	ingredients_started = true


	if icecream:
		icecream.start_timer()
