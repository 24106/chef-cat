extends Node2D

@onready var colour_rect = $ColorRect

var scene_to_load: String
var colour_rect_tween: Tween

func change_scene_to(scene_path: String) -> void:
	if colour_rect_tween:
		colour_rect_tween.kill()
	
	scene_to_load = scene_path
	
	colour_rect_tween = create_tween().set_trans(Tween.TRANS_SINE)
	colour_rect_tween.tween_property(colour_rect, "modulate:a", 2.0, 0.2).connect("finished", _load_new_scene)
	colour_rect_tween.chain().tween_property(colour_rect, "modulate:a", 0.0, 2.0)

func _load_new_scene() -> void:
	get_tree().call_deferred("change_scene_to_file", scene_to_load)
