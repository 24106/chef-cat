extends Node

@onready var music = $Music
@onready var sfx = $SFX

var jump = preload("res://assets/sound/sound effects/jump.mp3")
var collect = preload("res://assets/sound/sound effects/collect.mp3")
var death = preload("res://assets/sound/sound effects/death.mp3")
var door_open = preload("res://assets/sound/sound effects/door open.mp3")


func _ready():
	if not music.playing:
		music.play()


func play_sfx(sound):
	sfx.stream = sound
	sfx.play()
