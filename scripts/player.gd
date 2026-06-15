extends CharacterBody2D

@onready var sprint_bar = $CanvasLayer/ProgressBar

var speed = 600
var sprint_speed = 925
var current_speed = speed

var max_sprint_energy = 10
var sprint_energy = max_sprint_energy

var sprint_drain_rate = 2
var sprint_recharge_rate = 1

var recharge_timer = 0

const jump_power = -1850

const acceleration = 50
const friction = 50

const gravity = 100

const max_jumps = 2
var current_jumps = 1

func _physics_process(delta: float) -> void:
	sprint(delta)
	
	var input_direction: Vector2 = input()
	
	if input_direction != Vector2.ZERO:
		accelerate(input_direction)
	else:
		add_friction()
	player_movement()
	jump()

func input() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("player_left", "player_right")
	input_direction = input_direction.normalized()
	return input_direction

func accelerate(direction):
	velocity = velocity.move_toward(current_speed * direction, acceleration)

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


func sprint(delta):
	if Input.is_action_pressed("player_sprint") and sprint_energy > 0:
		current_speed = sprint_speed
		sprint_energy -= sprint_drain_rate * delta
		recharge_timer = 0
	else:
		current_speed = speed
		recharge_timer += delta
		if recharge_timer >= 1.5:
			sprint_energy += sprint_recharge_rate
			recharge_timer = 0
	sprint_energy = clamp(sprint_energy, 0, max_sprint_energy)
	sprint_bar.value = sprint_energy
