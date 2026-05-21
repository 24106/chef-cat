extends CharacterBody2D

const speed = 550
const jump_power = -2000

const acceleration = 50
const friction = 70

const gravity = 120

func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = input()
	
	if input_direction != Vector2.ZERO:
		accelerate(input_direction)
		#play movement animation
	else:
		add_friction()
		#play idle animation
	player_movement()

func input() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("ui_left", "ui_right")
	input_direction = input_direction.normalized()
	return input_direction

func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acceleration)

func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func player_movement():
	move_and_slide()
