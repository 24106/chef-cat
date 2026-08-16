extends Area2D


@export var ingredient_name = "tomatosauce"
@export var spoil_time = 10.0

var player_in_range = false
var collected = false
var spoiled = false

var timer = 0.0
var timer_started = false
var ticking_started = false

@onready var prompt = $sign


func _ready():
	prompt.visible = false
	add_to_group("ingredients")


func _process(delta):
	if timer_started and not spoiled:
		timer += delta

		var time_left = spoil_time - timer

		# Start ticking when 5 seconds are left
		if time_left <= 5.0 and not ticking_started:
			start_ticking()

		# Ingredient expires
		if timer >= spoil_time:
			spoil()


func start_ticking():
	ticking_started = true

	AudioManager.ticking.stream = AudioManager.clock_ticking
	AudioManager.ticking.play()


func stop_ticking():
	if AudioManager.ticking.playing:
		AudioManager.ticking.stop()

	ticking_started = false


func spoil():
	if spoiled:
		return

	spoiled = true

	# Stop the ticking
	stop_ticking()

	# Pause background music
	AudioManager.music.stream_paused = true

	# Play expired sound
	AudioManager.play_sfx(AudioManager.ingredient_expired)

	# Wait until the expired sound finishes
	await AudioManager.sfx.finished

	# Resume background music
	AudioManager.music.stream_paused = false

func start_timer():
	timer_started = true


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		prompt.visible = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false


func try_collect(player):
	if collected:
		return

	collected = true

	# Stop ticking if the player collects the ingredient
	stop_ticking()

	# Play collect sound
	AudioManager.play_sfx(AudioManager.collect)

	if spoiled:
		player.ingredient_failed = true
	else:
		player.add_ingredient(ingredient_name)

	queue_free()
