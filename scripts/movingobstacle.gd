extends CharacterBody2D

@export var speed = 120
var direction = 1

var start_y = 0
@export var travel_distance = 90

@export var sound_distance = 600

var up_sound_played = false
var down_sound_played = false


func _ready():
	start_y = global_position.y


func _physics_process(delta):
	velocity.y = speed * direction
	move_and_slide()

	var player = get_tree().get_first_node_in_group("player")

	var top_point = start_y - travel_distance
	var bottom_point = start_y + travel_distance

	# Knife is moving upward
	if direction == -1:
		down_sound_played = false

		if global_position.y <= top_point + 25:
			if not up_sound_played:
				if player and global_position.distance_to(player.global_position) <= sound_distance:
					AudioManager.play_sfx(AudioManager.knife_up)
				up_sound_played = true

	# Knife reaches the top and starts moving down
	if global_position.y <= top_point:
		direction = 1
		up_sound_played = false

	# Knife is moving downward
	if direction == 1:
		up_sound_played = false

		if global_position.y >= bottom_point - 25:
			if not down_sound_played:
				if player and global_position.distance_to(player.global_position) <= sound_distance:
					AudioManager.play_sfx(AudioManager.knife_down)
				down_sound_played = true

	# Knife reaches the bottom and starts moving up
	if global_position.y >= bottom_point:
		direction = -1
		down_sound_played = false


func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		AudioManager.play_sfx(AudioManager.death)
		get_tree().reload_current_scene()
