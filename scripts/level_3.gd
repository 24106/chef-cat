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
	show_tutorial()


func show_tutorial():
	tutorialpanel.visible = true
	tutorialbutton.visible = true
	tutorialtext.visible = true


func _physics_process(delta):
	check_ingredients()
	update_ingredient_UI()
	update_timer()




func update_timer():
	if icecream == null:
		icecream_timer.visible = false
		return

	icecream_timer.visible = true

	var time_left = icecream.spoil_time - icecream.timer

	if time_left > 0:
		icecream_timer.text = "Ice cream spoils in: " + str(round(time_left))
	else:
		icecream_timer.text = "Ice cream spoiled"

func _on_button_pressed() -> void:
	tutorialpanel.visible = false
	tutorialbutton.visible = false
	tutorialtext.visible = false
	start_ingredients()


func start_ingredients():
	if ingredients_started:
		return

	ingredients_started = true
	if icecream:
		icecream.start_timer()


func check_ingredients():
	if player.ingredient_failed:
		arrow.visible = false
		return

	arrow.visible = player.collected_ingredients.size() >= required_ingredients.size()


func update_ingredient_UI():
	icecream_label.text = "Ice cream ✓" if "icecream" in player.collected_ingredients else "Ice cream"
	chocolatesauce_label.text = "Chocolate sauce ✓" if "chocolatesauce" in player.collected_ingredients else "Chocolate sauce"
	strawberries_label.text = "Strawberries ✓" if "strawberries" in player.collected_ingredients else "Strawberries"
