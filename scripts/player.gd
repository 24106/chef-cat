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

var acceleration = 50
var friction = 50

var normal_acceleration = 50
var normal_friction = 50

var slippery_acceleration = 12
var slippery_friction = 3

const gravity = 100

const max_jumps = 2
var current_jumps = 0

var slippery = false
var ice_input_delay = 0

var collected_ingredients = []
var ingredient_failed = false

func _physics_process(delta: float) -> void:
	if slippery:
		ice_input_delay += delta
	else:
		ice_input_delay = 0

	sprint(delta)

	var input_direction: Vector2 = get_input()

	if slippery and ice_input_delay < 0.12:
		input_direction = Vector2.ZERO

	if input_direction != Vector2.ZERO:
		accelerate(input_direction)
	else:
		add_friction()

	player_movement()
	jump()

	if global_position.y > 3675:
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("mouse_click"):
		for area in get_tree().get_nodes_in_group("ingredients"):
			if area.player_in_range:
				area.try_collect(self)
				break

func get_input() -> Vector2:
	var input_direction = Vector2.ZERO
	input_direction.x = Input.get_axis("player_left", "player_right")
	return input_direction.normalized()

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

	velocity.y += gravity

	if is_on_floor():
		current_jumps = 0

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

func enter_slippery():
	slippery = true
	acceleration = slippery_acceleration
	friction = slippery_friction

func exit_slippery():
	slippery = false
	acceleration = normal_acceleration
	friction = normal_friction

func add_ingredient(name):
	if name not in collected_ingredients:
		collected_ingredients.append(name)
