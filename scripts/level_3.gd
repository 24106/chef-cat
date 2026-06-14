extends Node2D

func _physics_process(delta: float) -> void:
	pause()

func pause():
	if Input.is_action_just_pressed("pause"):
		print('PAUSE :(')
