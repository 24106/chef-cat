extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player reached kitchen")

		print("Ingredients:", body.collected_ingredients)

		if body.collected_ingredients.size() >= 3:
			print("WIN")
			get_tree().reload_current_scene()
		else:
			print("FAIL")
			get_tree().reload_current_scene()
