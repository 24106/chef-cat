extends Node

@onready var music = $Music
@onready var sfx = $SFX
@onready var ticking = $Ticking

var jump = preload("res://assets/sound/sound effects/jump.mp3")
var collect = preload("res://assets/sound/sound effects/collect.mp3")
var death = preload("res://assets/sound/sound effects/death.mp3")
var door_open = preload("res://assets/sound/sound effects/door open.mp3")
var knife_up = preload("res://assets/sound/sound effects/knife up.mp3")
var knife_down = preload("res://assets/sound/sound effects/knife down.mp3")

var right_option = preload("res://assets/sound/sound effects/rightoption.mp3")
var wrong_option = preload("res://assets/sound/sound effects/wrongoption.mp3")

var level1_win = preload("res://assets/sound/levels/level1win.mp3")
var level2_win = preload("res://assets/sound/levels/level2win.mp3")
var level3_win = preload("res://assets/sound/levels/level3win.mp3")
var level_fail = preload("res://assets/sound/levels/levelfail.mp3")

var clock_ticking = preload("res://assets/sound/sound effects/clock ticking.mp3")
var ingredient_expired = preload("res://assets/sound/sound effects/ingredient expired.mp3")

func _ready():
	if not music.playing:
		music.play()

func play_sfx(sound):
	sfx.stream = sound
	sfx.play()

func play_sfx_and_pause_music(sound):
	music.stream_paused = true
	sfx.stream = sound
	sfx.play()
	await sfx.finished
	music.stream_paused = false
	
