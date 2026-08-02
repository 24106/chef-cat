extends CharacterBody2D

@onready var sprint_bar = $CanvasLayer/ProgressBar
@onready var animated_sprite = $AnimatedSprite2D

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
enum CatState {
	NORMAL,
	GOING_TO_SLEEP,
	ASLEEP,
	WAKING
}
var cat_state = CatState.NORMAL
const SLEEP_DELAY = 3.5
var idle_timer = 0.0
var can_move = true


func _physics_process(delta: float) -> void:
	if slippery:
		ice_input_delay += delta
	else:
		ice_input_delay = 0
	sprint(delta)
	var input_direction: Vector2 = get_input()
	if slippery and ice_input_delay < 0.12:
		input_direction = Vector2.ZERO
	if can_move:
		if input_direction != Vector2.ZERO:
			accelerate(input_direction)
		else:
			add_friction()
	else:
			velocity.x = move_toward(velocity.x, 0.0, friction)
	player_movement()
	jump()
	update_animation(delta)
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
	if !can_move:
		return
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


func update_animation(delta):
	var moving = abs(velocity.x) > 10
	var has_input = Input.get_axis("player_left", "player_right") != 0
	var airborne = !is_on_floor()
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0
	match cat_state:
		CatState.NORMAL:
			if moving or airborne:
				idle_timer = 0
				if animated_sprite.animation != "move":
					animated_sprite.play("move")
			else:
				if animated_sprite.animation != "standing":
					animated_sprite.play("standing")
				idle_timer += delta
				if idle_timer >= SLEEP_DELAY:
					idle_timer = 0
					can_move = false
					cat_state = CatState.GOING_TO_SLEEP
					animated_sprite.play("going_to_sleep")
		CatState.GOING_TO_SLEEP:
			pass
		CatState.ASLEEP:
			if animated_sprite.animation != "asleep":
				animated_sprite.play("asleep")
			if has_input:
				cat_state = CatState.WAKING
				animated_sprite.play("waking")
		CatState.WAKING:
			pass


func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _on_animation_finished():
	match animated_sprite.animation:
		"going_to_sleep":
			cat_state = CatState.ASLEEP
			animated_sprite.play("asleep")
		"waking":
			can_move = true
			idle_timer = 0
			cat_state = CatState.NORMAL
			if abs(Input.get_axis("player_left", "player_right")) > 0:
				animated_sprite.play("move")
			else:
				animated_sprite.play("standing")
