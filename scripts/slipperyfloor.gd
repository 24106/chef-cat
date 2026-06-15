extends Area2D

func _on_body_entered(body):
	if body.has_method("enter_slippery"):
		body.enter_slippery()


func _on_body_exited(body):
	if body.has_method("exit_slippery"):
		body.exit_slippery()
