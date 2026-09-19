extends CharacterBody2D

@onready var main_node: Control = $".."
@onready var hunting_time_label: Label = $"../HuntingTimeLabel"
@onready var hunting_timer: Timer = $HuntingTimer

var insence_in: bool = false
var ghost_discovered: bool = false

func _physics_process(delta: float) -> void:
	hunting_time_label.text = str(snappedf(hunting_timer.time_left, 0.1))

func _on_level_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("insence") and main_node.item_selected == 5:
		insence_in = true
	if body.is_in_group("camera") and main_node.item_selected == 4:
		ghost_discovered = true
		print("DING DING DING, GHOST DISCOVERED")


func _on_level_5_body_exited(body: Node2D) -> void:
	if body.is_in_group("insence") and main_node.item_selected == 5:
		insence_in = false

func check_insence():
	if insence_in and ghost_discovered:
		_finished_hunt()

func _start_hunt():
	ghost_discovered = false
	hunting_timer.start()
	Music.is_hunting = true

func _finished_hunt():
	ghost_discovered = false
	hunting_timer.stop()
	Music.is_hunting = false

func _on_hunting_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/Loose.tscn")
