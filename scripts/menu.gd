extends Control

@onready var high_score_label: Label = $HighScoreLabel

func _ready() -> void:
	high_score_label.text = str(GlobalVars.high_score)

func _on_start_label_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_credits_label_pressed() -> void:
	pass # Replace with function body.


func _on_quit_label_pressed() -> void:
	get_tree().quit()
