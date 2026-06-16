extends Node

var current_level = ""

var player_position = Vector2.ZERO
var collected_ingredients = []
var ingredient_failed = false

var tomatosauce_time = 0
var icecream_time = 0

var paused = false

func reset_data():

	current_level = ""

	player_position = Vector2.ZERO

	collected_ingredients.clear()

	ingredient_failed = false

	tomatosauce_time = 0
