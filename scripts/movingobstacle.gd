extends CharacterBody2D

@export var speed = 120
var direction = 1

var start_y = 0
@export var travel_distance = 90  # how far it moves up/down

func _ready():
	start_y = global_position.y

func _physics_process(delta):
	velocity.y = speed * direction
	move_and_slide()

	if global_position.y < start_y - travel_distance:
		direction = 1

	if global_position.y > start_y + travel_distance:
		direction = -1
