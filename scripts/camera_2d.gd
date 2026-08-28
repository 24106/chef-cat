extends Camera2D

# Camera variables
@export var random_strength: float = 10.0
@export var shake_fade: float = 5.0

var shake_strength: float = 0.0
var rng = RandomNumberGenerator.new()


# Camera shake function
func apply_shake(strength: float = random_strength):
	shake_strength = strength


func _process(delta: float):
	if shake_strength > 0.0:
		shake_strength = lerp(shake_strength, 0.0, shake_fade * delta)
		offset = random_offset()
	else:
		offset = Vector2.ZERO


func random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_strength, shake_strength),
		rng.randf_range(-shake_strength, shake_strength)
	)
