extends CharacterBody2D

var speed = 600
var sprint_speed = 800
const jump_power = -1850

const acceleration = 40
const friction = 50

const gravity = 100

const max_jumps = 2
var current_jumps = 1

func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = input()
	
	if input_direction != Vector2.ZERO:
		accelerate(input_direction)
		#play movement animation
	else:
		add_friction()
		#play idle animation
	player_movement()
	jump()

func input() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("player_left", "player_right")
	input_direction = input_direction.normalized()
	return input_direction

func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acceleration)

func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func player_movement():
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("player_jump"):
		if current_jumps < max_jumps:
			velocity.y = jump_power
			current_jumps += 1
	else:
		velocity.y += gravity
	
	if is_on_floor():
		current_jumps = 1
