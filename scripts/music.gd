extends Node

@onready var calm: AudioStreamPlayer = $Calm
@onready var danger: AudioStreamPlayer = $Danger

var is_hunting: bool = true
var is_danger: bool = false
var lost: bool = false

func _physics_process(delta: float) -> void:
	if is_danger:
		danger.volume_db = 0
		calm.volume_db = -100000000000
	else:
		calm.volume_db = 0
		danger.volume_db = -100000000000
	
	if is_hunting:
		AudioServer.set_bus_effect_enabled(1,0,true)
	else:
		AudioServer.set_bus_effect_enabled(1,0,false)
	
	if lost:
		calm.pitch_scale = 0.5
	else:
		calm.pitch_scale = 1.0
