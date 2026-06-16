extends Node2D

var required_ingredients = ["pasta", "tomatosauce", "mushrooms"]
var ingredients_started = false

@onready var arrow = $"UI layer"/arrow
@onready var player = $player

@onready var tutorialpanel = $"UI layer"/tutorialpanel
@onready var tutorialtext = $"UI layer"/tutorialpanel/Label
@onready var tutorialbutton = $"UI layer"/tutorialpanel/Button

@onready var pasta_label = $"UI layer"/ingredientUI/pastatext
@onready var tomatosauce_label = $"UI layer"/ingredientUI/tomatosaucetext
@onready var mushrooms_label = $"UI layer"/ingredientUI/mushroomstext

@onready var tomatosauce_timer = $"UI layer"/tomatosauce_timer
@onready var tomatosauce = $ingredients/tomatosauce


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
	if tomatosauce == null:
		tomatosauce_timer.visible = false
		return

	tomatosauce_timer.visible = true

	var time_left = tomatosauce.spoil_time - tomatosauce.timer

	if time_left > 0:
		tomatosauce_timer.text = "Spoils in: " + str(round(time_left))
	else:
		tomatosauce_timer.text = "Tomato sauce spoiled"

func _on_button_pressed() -> void:
	tutorialpanel.visible = false
	tutorialbutton.visible = false
	tutorialtext.visible = false
	start_ingredients()


func start_ingredients():
	if ingredients_started:
		return

	ingredients_started = true
	if tomatosauce:
		tomatosauce.start_timer()


func check_ingredients():
	if player.ingredient_failed:
		arrow.visible = false
		return

	arrow.visible = player.collected_ingredients.size() >= required_ingredients.size()


func update_ingredient_UI():
	pasta_label.text = "Pasta ✓" if "pasta" in player.collected_ingredients else "Pasta"
	tomatosauce_label.text = "Tomato sauce ✓" if "tomatosauce" in player.collected_ingredients else "Tomato sauce"
	mushrooms_label.text = "Mushrooms ✓" if "mushrooms" in player.collected_ingredients else "Mushrooms"
