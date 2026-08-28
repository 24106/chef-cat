extends Node2D

@onready var main_section = $mainsection
@onready var level_section = $levelselectsection
@onready var tutorial_section = $tutorialsection

@onready var tutorial_title = $tutorialsection/TutorialTitle
@onready var tutorial_image = $tutorialsection/TutorialImage
@onready var tutorial_text = $tutorialsection/TutorialText
@onready var tutorial_back_button = $tutorialsection/BackButton
@onready var tutorial_next_button = $tutorialsection/NextButton
@onready var tutorial_page_number = $tutorialsection/PageNumber

var tutorial_page = 0

func _ready():
	main_section.show()
	level_section.hide()
	tutorial_section.hide()

# main section buttons
func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_quit_game_button_pressed() -> void:
	get_tree().quit()

func _on_select_level_button_pressed() -> void:
	main_section.hide()
	level_section.show()

func _on_tutorial_button_pressed() -> void:
	main_section.hide()
	level_section.hide()
	tutorial_section.show()

	tutorial_page = 0
	update_tutorial()


# level select section buttons
func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")

func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")

func _on_back_button_pressed() -> void:
	main_section.show()
	level_section.hide()

func update_tutorial() -> void:
	match tutorial_page:
		0:
			tutorial_title.text = "Controls"
			tutorial_image.texture = load("res://assets/ui/controls.png")
			tutorial_text.text = "(You can double and triple jump!)

Use arrow keys, WASD keys or space 
key for movement.

To sprint, hold down 'Shift'.

(On the last level, you can fall off the 
platforms and die.)"
			tutorial_page_number.text = "1 / 3"
			tutorial_back_button.hide()
			tutorial_next_button.text = ">>"

		1:
			tutorial_title.text = "Obstacles"
			tutorial_image.texture = load("res://assets/ui/obstacles.png")
			tutorial_text.text = "If you run into a moving knife,
you will die and restart the level. 

If you run over the pink slippery floors,
you will slide and your movements will
be delayed."
			tutorial_page_number.text = "2 / 3"
			tutorial_back_button.show()
			tutorial_next_button.text = ">>"

		2:
			tutorial_title.text = "Your Goal"
			tutorial_image.texture = load("res://assets/ui/goal.png")
			tutorial_text.text = "Collect all the ingredients displayed
at the top of the screen. 

Then go to the kitchen door and
successfully make the dish!!"
			tutorial_page_number.text = "3 / 3"
			tutorial_next_button.text = ">>"


func _on_next_button_pressed() -> void:
	if tutorial_page < 2:
		tutorial_page += 1
		update_tutorial()
	else:
		main_section.show()
		tutorial_section.hide()

func _on_tutorial_back_button_pressed() -> void:
	if tutorial_page > 0:
		tutorial_page -= 1
		update_tutorial()
